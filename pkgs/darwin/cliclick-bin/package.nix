{
  lib,
  stdenvNoCC,
  sources,
  unzip,
}:
stdenvNoCC.mkDerivation (_finalAttrs: {
  pname = "cliclick";
  inherit (sources.cliclick) version src;

  nativeBuildInputs = [unzip];

  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ./cliclick $out/bin/
    chmod +x $out/bin/cliclick

    runHook postInstall
  '';

  meta = {
    description = "A macOS CLI tool for emulating mouse and keyboard events";
    homepage = "https://github.com/BlueM/cliclick";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
