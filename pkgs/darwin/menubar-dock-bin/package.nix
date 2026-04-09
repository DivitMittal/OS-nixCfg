{
  stdenvNoCC,
  lib,
  sources,
  makeWrapper,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "Menu Bar Dock";
  inherit (sources.menubar-dock) version src;

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
