{
  stdenvNoCC,
  fetchurl,
  lib,
  makeWrapper,
  _7zz,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "LibreScore";
  version = "6.0.22";

  src = fetchurl {
    url = "https://github.com/LibreScore/app-librescore/releases/download/v${finalAttrs.version}/LibreScore.dmg";
    hash = "sha256-FVooTBCPaE8chR8YOjiQFi8L9G7anHICrufYDQjIh08=";
  };

  nativeBuildInputs = [_7zz makeWrapper];

  unpackPhase = ''7zz x -snld $src'';

  sourceRoot = "LibreScore.app";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/LibreScore.app"
    cp -R . "$out/Applications/LibreScore.app"

    if [[ -e "$out/Applications/LibreScore.app/Contents/MacOS/LibreScore" ]]; then
      makeWrapper "$out/Applications/LibreScore.app/Contents/MacOS/LibreScore" "$out/bin/librescore"
    fi

    runHook postInstall
  '';

  meta = {
    description = "Download sheet music from musescore.com for free";
    homepage = "https://github.com/LibreScore/app-librescore";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "librescore";
  };
})
