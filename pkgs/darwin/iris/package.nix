{
  stdenvNoCC,
  fetchzip,
  lib,
  makeWrapper,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "iris";
  version = "0.2.0-hotkey";

  src = fetchzip {
    extension = "zip";
    url = "https://github.com/DivitMittal/Iris/releases/download/v${finalAttrs.version}/Iris-v${finalAttrs.version}.zip";
    hash = "sha256-ZHXw2+Fpm6+cXo01oNrXa7iQW4HMmic3KkVrD50a1hA=";
  };

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/Iris.app"
    cp -R ./* "$out/Applications/Iris.app"

    mkdir -p "$out/bin"
    makeWrapper "$out/Applications/Iris.app/Contents/MacOS/Iris" "$out/bin/iris"

    runHook postInstall
  '';

  meta = {
    description = "Webcam mirror window for macOS with hotkey toggle";
    homepage = "https://github.com/DivitMittal/Iris";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
