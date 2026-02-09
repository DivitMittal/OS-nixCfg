{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "unxip";
  version = "3.3";

  src = fetchurl {
    url = "https://github.com/saagarjha/unxip/releases/download/v${finalAttrs.version}/unxip";
    hash = "sha256-R12///1w4GcV+Wa4eI+N02dy8zCzNg/272/x/M0vFP4=";
  };

  dontUnpack = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp $src $out/bin/unxip
    chmod +x $out/bin/unxip

    runHook postInstall
  '';

  meta = {
    description = "A fast Xcode unarchiver";
    homepage = "https://github.com/saagarjha/unxip";
    license = lib.licenses.lgpl3Only;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "unxip";
  };
})
