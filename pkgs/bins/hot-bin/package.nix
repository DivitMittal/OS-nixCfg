{
  lib,
  stdenvNoCC,
  fetchzip,
  unzip,
  makeWrapper,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "Hot";
  version = "1.9.4";
  src = fetchzip {
    extension = "zip";
    url = "https://github.com/macmade/${finalAttrs.pname}/releases/download/${finalAttrs.version}/${finalAttrs.pname}.zip";
    hash = "sha256-OWE3ECP3xZjHj30y7M37jfRNfQoUy+MYTaUsQrg+dLo=";
  };

  nativeBuildInputs = [unzip makeWrapper];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications/${finalAttrs.pname}.app
    cp -R ./* $out/Applications/${finalAttrs.pname}.app/

    if [[ -e $out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname} ]]; then
      makeWrapper $out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname} $out/bin/${finalAttrs.pname}
    fi

    runHook postInstall
  '';

  meta = {
    description = "Hot is macOS menu bar application that displays the CPU speed limit due to thermal issues";
    homepage = "https://github.com/macmade/Hot";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})