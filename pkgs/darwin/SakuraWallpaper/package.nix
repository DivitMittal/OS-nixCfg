{
  lib,
  stdenvNoCC,
  sources,
  _7zz,
}:
stdenvNoCC.mkDerivation {
  inherit (sources.SakuraWallpaper) pname src;
  version = lib.removePrefix "v" sources.SakuraWallpaper.version;

  nativeBuildInputs = [_7zz];

  unpackPhase = ''7zz x -snld $src'';

  sourceRoot = "SakuraWallpaper.app";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/SakuraWallpaper.app"
    cp -R . "$out/Applications/SakuraWallpaper.app"

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
