{
  stdenvNoCC,
  lib,
  sources,
  makeWrapper,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "LosslessSwitcher";
  inherit (sources.LosslessSwitcher) version src;

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
    description = "Lossless audio output device switcher for macOS";
    homepage = "https://github.com/vincentneo/LosslessSwitcher";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
