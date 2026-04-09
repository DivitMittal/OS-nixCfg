{
  lib,
  stdenvNoCC,
  sources,
  unzip,
  makeWrapper,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "Pearcleaner";
  inherit (sources.Pearcleaner) version src;

  nativeBuildInputs = [unzip makeWrapper];

  sourceRoot = ".";

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
