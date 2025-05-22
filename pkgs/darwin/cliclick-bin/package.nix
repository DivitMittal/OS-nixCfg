{
  lib,
  stdenvNoCC,
  fetchzip,
  unzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "cliclick";
  version = "5.1";

  src = fetchzip {
    extension = "zip";
    url = "https://github.com/BlueM/${finalAttrs.pname}/releases/download/${finalAttrs.version}/${finalAttrs.pname}.zip";
    hash = "sha256-rkrzSwFZ9ZQs68F2jFIIQ+VbgnRfZLBv5tNxBwh5WM8=";
  };

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
