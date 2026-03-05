{
  lib,
  stdenvNoCC,
  fetchzip,
  unzip,
  makeWrapper,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "Pearcleaner";
  version = "5.4.3";
  src = fetchzip {
    extension = "zip";
    url = "https://github.com/alienator88/${finalAttrs.pname}/releases/download/${finalAttrs.version}/${finalAttrs.pname}.zip";
    stripRoot = false;
    hash = "sha256-Afnd0EaNosuhD8oP1Q/HVzaCWQAvNBIeoDbKKpTY//4=";
  };

  nativeBuildInputs = [unzip makeWrapper];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    cp -R "${finalAttrs.pname}.app" "$out/Applications/${finalAttrs.pname}.app"

    if [[ -e "$out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname}" ]]; then
      makeWrapper "$out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname}" "$out/bin/${finalAttrs.pname}"
    fi

    runHook postInstall
  '';

  meta = {
    description = "A free, source-available and fair-code licensed mac app cleaner";
    homepage = "https://github.com/alienator88/Pearcleaner";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
