{
  lib,
  stdenv,
  swift,
  sources,
}:
stdenv.mkDerivation {
  pname = "ccs-bar";
  version = lib.removePrefix "v" sources.ccs-bar.version;
  inherit (sources.ccs-bar) src;

  # ccs is a monorepo; the bar app lives under macos-bar/
  postUnpack = "sourceRoot=$sourceRoot/macos-bar";

  nativeBuildInputs = [swift];

  buildPhase = ''
    runHook preBuild
    export HOME=$TMPDIR
    swift build -c release --product CCSBar
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
