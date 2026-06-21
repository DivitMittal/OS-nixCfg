{
  lib,
  stdenvNoCC,
  sources,
}:
stdenvNoCC.mkDerivation {
  inherit (sources.SakuraWallpaper) pname version src;

  unpackPhase = ''
    MOUNTDIR=$(mktemp -d)
    /usr/bin/hdiutil attach -readonly -nobrowse -mountpoint "$MOUNTDIR" $src
    cp -R "$MOUNTDIR/SakuraWallpaper.app" .
    /usr/bin/hdiutil detach "$MOUNTDIR"
  '';

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    cp -R SakuraWallpaper.app "$out/Applications/"

    runHook postInstall
  '';

  meta = {
    description = "Dynamic wallpaper app — set videos and images as live macOS wallpapers";
    homepage = "https://github.com/yueseqaz/SakuraWallpaper";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
}
