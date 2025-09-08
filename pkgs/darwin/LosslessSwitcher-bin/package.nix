{
  stdenvNoCC,
  fetchzip,
  lib,
  makeWrapper,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "LosslessSwitcher";
  version = "2.0-beta2";
  src = fetchzip {
    extension = "zip";
    url = "https://github.com/vincentneo/${finalAttrs.pname}/releases/download/${finalAttrs.version}/${finalAttrs.pname}2-b2.app.zip";
    hash = "sha256-a59UxVVmSV0AIw86MghCL6p19q2WxYORqaY4hgdXTU0=";
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
    description = "Lossless audio output device switcher for macOS";
    homepage = "https://github.com/vincentneo/LosslessSwitcher";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
