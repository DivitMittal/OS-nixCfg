{
  stdenvNoCC,
  fetchurl,
  lib,
  makeWrapper,
  _7zz,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "LiveWallpaper";
  version = "2.1";

  src = fetchurl {
    url = "https://github.com/thusvill/LiveWallpaperMacOS/releases/download/V${finalAttrs.version}/LiveWallpaper.dmg";
    hash = "sha256-r8EgYmatQOtjT3oBx5VZN7kGwjHTobKhWA+5VYbBtc4=";
  };

  nativeBuildInputs = [_7zz makeWrapper];

  unpackPhase = ''7zz x -snld $src'';

  sourceRoot = "LiveWallpaper.app";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/LiveWallpaper.app"
    cp -R . "$out/Applications/LiveWallpaper.app"

    if [[ -e "$out/Applications/LiveWallpaper.app/Contents/MacOS/LiveWallpaper" ]]; then
      makeWrapper "$out/Applications/LiveWallpaper.app/Contents/MacOS/LiveWallpaper" "$out/bin/livewallpaper"
    fi

    runHook postInstall
  '';

  meta = {
    description = "Open source live wallpaper solution for macOS";
    homepage = "https://github.com/thusvill/LiveWallpaperMacOS";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "livewallpaper";
  };
})
