{
  stdenvNoCC,
  fetchzip,
  lib,
  makeWrapper,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "Iris";
  version = "0.1.4";

  src = fetchzip {
    extension = "zip";
    url = "https://github.com/ahmetb/Iris/releases/download/v${finalAttrs.version}/Iris-v${finalAttrs.version}.zip";
    hash = "sha256-4x7D/D5G2ZVJjabdNGTwZoFoT9hMrKb9PSEDfwdkQKA=";
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
    description = "Webcam mirror window for macOS";
    homepage = "https://github.com/ahmetb/Iris";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
