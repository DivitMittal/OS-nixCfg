{
  stdenvNoCC,
  fetchzip,
  lib,
  makeWrapper,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "MultiSoundChanger";
  version = "1.0.1-BetterDisplay";
  src = fetchzip {
    extension = "zip";
    url = "https://github.com/aonez/${finalAttrs.pname}/releases/download/${finalAttrs.version}/MultiSoundChanger+BetterDisplay.zip";
    hash = "sha256-9UKDbL0WWoRzaF1ctkjU495Al9tpqJRepMA+9poDCGQ=";
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
    description = "Aggregate output device sound changer for macOS with BetterDisplay support";
    homepage = "https://github.com/aonez/MultiSoundChanger";
    license = lib.licenses.unlicense;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
