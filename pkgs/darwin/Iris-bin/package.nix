{
  stdenvNoCC,
  lib,
  sources,
  makeWrapper,
  ...
}:
stdenvNoCC.mkDerivation (_finalAttrs: {
  pname = "Iris";
  inherit (sources.Iris) version src;

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
