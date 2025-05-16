{
  stdenvNoCC,
  fetchzip,
  lib,
  makeWrapper,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "Menu Bar Dock";
  version = "4.6";
  src = fetchzip {
    extension = "zip";
    url = "https://github.com/EthanSK/Menu-Bar-Dock/releases/download/${finalAttrs.version}/Menu.Bar.Dock.app.zip";
    hash = "sha256-QHOBIZ5HqPZ/iINr/1/E51OIMVhbNBGDhBGC6O+8k0E=";
  };

  nativeBuildInputs = [unzip makeWrapper];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/${finalAttrs.pname}.app"
    cp -R ./* "$out/Applications/${finalAttrs.pname}.app"

    if [[ -e "$out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname}" ]]; then
      makeWrapper "$out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname}" "$out/bin/${finalAttrs.pname}"
    fi

    runHook postInstall
  '';

  meta = {
    description = "Put the MacOS dock of apps in the menu bar (with customizability)";
    homepage = "https://github.com/EthanSK/Menu-Bar-Dock";
    license = lib.licenses.unlicense;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})