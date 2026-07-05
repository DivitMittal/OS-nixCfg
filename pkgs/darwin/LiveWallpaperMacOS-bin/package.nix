{
  lib,
  stdenvNoCC,
  sources,
}:
stdenvNoCC.mkDerivation {
  pname = "LiveWallpaperMacOS-bin";
  inherit (sources.LiveWallpaperMacOS) version src;

  unpackPhase = ''
    MOUNTDIR=$(mktemp -d)
    cleanup() {
      /usr/bin/hdiutil detach "$MOUNTDIR" || true
    }
    trap cleanup EXIT

    /usr/bin/hdiutil attach -readonly -nobrowse -mountpoint "$MOUNTDIR" "$src"
    cp -R "$MOUNTDIR/LiveWallpaper.app" .

    cleanup
    trap - EXIT
  '';

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    cp -R LiveWallpaper.app "$out/Applications/"

    runHook postInstall
  '';

  meta = {
    description = "Open-source live wallpaper application for macOS";
    homepage = "https://github.com/thusvill/LiveWallpaperMacOS";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
}
