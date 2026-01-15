{
  stdenvNoCC,
  fetchzip,
  lib,
  makeWrapper,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "CodexBar";
  version = "0.17.0";
  src = fetchzip {
    extension = "zip";
    url = "https://github.com/steipete/CodexBar/releases/download/v${finalAttrs.version}/CodexBar-${finalAttrs.version}.zip";
    hash = "sha256-tPGYIqrSRDpLYv2yP2EA6dFVpAfaL+gPxaR3osbYBnU=";
  };

  nativeBuildInputs = [unzip makeWrapper];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/${finalAttrs.pname}.app"
    cp -R ./* "$out/Applications/${finalAttrs.pname}.app"

    if [[ -e "$out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname}" ]]; then
      mkdir -p "$out/bin"
      makeWrapper "$out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname}" "$out/bin/${finalAttrs.pname}"
    fi

    runHook postInstall
  '';

  meta = {
    description = "macOS menu bar app showing Codex, Claude, Cursor, Gemini, Copilot limits";
    homepage = "https://github.com/steipete/CodexBar";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
