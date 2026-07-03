{
  lib,
  stdenv,
  sources,
}:
stdenv.mkDerivation {
  pname = "ccs-bar";
  version = lib.removePrefix "v" sources.ccs-bar.version;
  inherit (sources.ccs-bar) src;

  # ccs is a monorepo; the bar app lives under macos-bar/
  postUnpack = "sourceRoot=$sourceRoot/macos-bar";

  # Builds with the system Xcode toolchain: the nix apple-sdk has no `swift`
  # binary, and the darwin stdenv exports DEVELOPER_DIR + SDKROOT at the nix
  # apple-sdk store path — an SDK built for an older Swift than Xcode's
  # compiler, so swiftc aborts ("this SDK is not supported by the compiler").
  # We drop both so xcode-select/xcrun resolve the real Xcode, then disable
  # SwiftPM's sandbox-exec (the nix build user cannot apply it: EPERM).
  buildPhase = ''
    runHook preBuild
    export HOME=$TMPDIR
    unset DEVELOPER_DIR SDKROOT
    export DEVELOPER_DIR="$(/usr/bin/xcode-select -p)"
    /usr/bin/xcrun swift build -c release --disable-sandbox --product CCSBar
    runHook postBuild
  '';

  dontFixup = true;

  installPhase = ''
    runHook preInstall

    app="$out/Applications/CCS Bar.app"
    mkdir -p "$app/Contents/MacOS" "$app/Contents/Resources"

    cp .build/release/CCSBar "$app/Contents/MacOS/CCSBar"
    chmod +x "$app/Contents/MacOS/CCSBar"

    sed "s/__VERSION__/$version/g" Resources/Info.plist > "$app/Contents/Info.plist"

    cp Resources/Assets/*.png "$app/Contents/Resources/"

    runHook postInstall
  '';

  meta = {
    description = "Native macOS menu bar client for CCS — quota, cost and tier at a glance";
    homepage = "https://github.com/kaitranntt/ccs";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
  };
}
