{
  lib,
  stdenv,
  sources,
  darwin,
}:
stdenv.mkDerivation {
  inherit (sources.VoltageShift) pname src version;

  buildInputs = with darwin.apple_sdk.frameworks; [
    IOKit
    Foundation
  ];

  # Strip breaks kext binary — keep debug symbols intact.
  dontStrip = true;

  buildPhase = ''
    runHook preBuild

    cp -r ${sources.MacKernelSDK.src} MacKernelSDK
    chmod -R u+w MacKernelSDK

    # User-space CLI: communicates with the kext via IOKit
    clang++ \
      -arch x86_64 \
      -std=gnu++11 \
      -mmacosx-version-min=10.12 \
      -include VoltageShift/VoltageShift-Prefix.pch \
      -framework IOKit \
      -framework Foundation \
      voltageshiftd/main.mm \
      -o voltageshiftd

    # Kernel extension — x86_64 Intel only (kext writes CPU MSRs directly)
    clang++ \
      -arch x86_64 \
      -mkernel \
      -nostdlib \
      -std=gnu++11 \
      -fno-builtin \
      -fno-common \
      -fno-non-call-exceptions \
      -fno-asynchronous-unwind-tables \
      -mmmx -msse -msse2 -msse3 -mfpmath=sse -mssse3 \
      -ftree-vectorize \
      -Wno-inconsistent-missing-override \
      -Wno-unknown-warning-option \
      -Wno-ossharedptr-misuse \
      -Wno-stdlibcxx-not-found \
      -include VoltageShift/VoltageShift-Prefix.pch \
      -I MacKernelSDK/Headers \
      -c VoltageShift/VoltageShfit.cpp \
      -o VoltageShift.o

    # ld -kext produces a kernel-loadable bundle (statically linked, MH_KEXT_BUNDLE)
    /usr/bin/ld \
      -arch x86_64 \
      -kext \
      VoltageShift.o \
      MacKernelSDK/Library/x86_64/libkmod.a \
      -o VoltageShift_kext_bin

    runHook postBuild
  '';

  installPhase = ''
        runHook preInstall

        mkdir -p "$out/bin"
        install -m755 voltageshiftd "$out/bin/voltageshiftd"

        # Assemble the kext bundle
        kextDir="$out/lib/VoltageShift.kext"
        mkdir -p "$kextDir/Contents/MacOS"
        mkdir -p "$kextDir/Contents/Resources/en.lproj"
        install -m755 VoltageShift_kext_bin "$kextDir/Contents/MacOS/VoltageShift"
        cp VoltageShift/en.lproj/InfoPlist.strings \
          "$kextDir/Contents/Resources/en.lproj/"

        # Info.plist — Xcode template vars expanded to their Release values
        cat > "$kextDir/Contents/Info.plist" << 'PLIST'
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    	<key>CFBundleDevelopmentRegion</key>
    	<string>English</string>
    	<key>CFBundleExecutable</key>
    	<string>VoltageShift</string>
    	<key>CFBundleGetInfoString</key>
    	<string>1.30, Copyright (c) 2020 SC Lee. All rights reserved.</string>
    	<key>CFBundleIdentifier</key>
    	<string>com.sicreative.VoltageShift</string>
    	<key>CFBundleInfoDictionaryVersion</key>
    	<string>6.0</string>
    	<key>CFBundleName</key>
    	<string>VoltageShift</string>
    	<key>CFBundlePackageType</key>
    	<string>KEXT</string>
    	<key>CFBundleShortVersionString</key>
    	<string>1.30</string>
    	<key>CFBundleSignature</key>
    	<string>????</string>
    	<key>CFBundleVersion</key>
    	<string>1.30</string>
    	<key>IOKitPersonalities</key>
    	<dict>
    		<key>VoltageShift</key>
    		<dict>
    			<key>CFBundleIdentifier</key>
    			<string>com.sicreative.VoltageShift</string>
    			<key>IOClass</key>
    			<string>VoltageShift</string>
    			<key>IOMatchCategory</key>
    			<string>VoltageShift</string>
    			<key>IOProviderClass</key>
    			<string>IOResources</string>
    			<key>IOResourceMatch</key>
    			<string>IOKit</string>
    			<key>IOUserClientClass</key>
    			<string>AnVMSRClient</string>
    		</dict>
    	</dict>
    	<key>NSHumanReadableCopyright</key>
    	<string>Copyright (c) 2020 SC Lee. All rights reserved.</string>
    	<key>OSBundleCompatibleVersion</key>
    	<string>1.30</string>
    	<key>OSBundleLibraries</key>
    	<dict>
    		<key>com.apple.kpi.iokit</key>
    		<string>8.0.0b1</string>
    		<key>com.apple.kpi.libkern</key>
    		<string>8.0.0b1</string>
    	</dict>
    	<key>OSBundleRequired</key>
    	<string>Root</string>
    </dict>
    </plist>
    PLIST

        # Kext loader — copies bundle to /tmp, fixes ownership, loads it
        cat > "$out/bin/voltageshift-load-kext" << EOF
    #!/bin/bash
    set -euo pipefail
    KEXT_SRC="$out/lib/VoltageShift.kext"
    KEXT_DEST="/tmp/VoltageShift.kext"

    echo "Copying VoltageShift.kext to /tmp..."
    rm -rf "\$KEXT_DEST"
    cp -r "\$KEXT_SRC" "\$KEXT_DEST"
    find "\$KEXT_DEST" -type d -exec chmod 755 {} \;
    find "\$KEXT_DEST" -type f -exec chmod 644 {} \;
    chmod 755 "\$KEXT_DEST/Contents/MacOS/VoltageShift"
    sudo chown -R root:wheel "\$KEXT_DEST"

    mac_major="\$(sw_vers -productVersion | cut -d. -f1)"
    if (( mac_major >= 11 )); then
      echo "Loading via kmutil (macOS \$mac_major)..."
      sudo kmutil load -p "\$KEXT_DEST"
    else
      echo "Loading via kextutil (macOS \$mac_major)..."
      sudo kextutil -r /tmp -b com.sicreative.VoltageShift "\$KEXT_DEST"
    fi
    echo "Done. Try: voltageshiftd info"
    EOF
        chmod +x "$out/bin/voltageshift-load-kext"

        runHook postInstall
  '';

  meta = {
    description = "CPU undervolting and power management for Intel Macs via kext";
    longDescription = ''
      VoltageShift exposes Intel CPU voltage offsets (undervolting) and turbo
      boost settings via a kernel extension and a CLI. Load the kext with
      voltageshift-load-kext (requires SIP kext-loading allowed), then use
      voltageshiftd to read/set voltage and power limits.
      Intel x86_64 only — Apple Silicon is unsupported.
    '';
    homepage = "https://github.com/asepms92/VoltageShift";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = ["x86_64-darwin"];
    mainProgram = "voltageshiftd";
  };
}
