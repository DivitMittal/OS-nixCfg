{
  lib,
  stdenvNoCC,
  sources,
}:
stdenvNoCC.mkDerivation (_finalAttrs: {
  pname = "unxip";
  inherit (sources.unxip) version src;

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
