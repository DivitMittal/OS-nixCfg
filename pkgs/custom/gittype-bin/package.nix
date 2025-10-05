{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "gittype";
  version = "0.8.0";

  src = let
    platform =
      {
        "x86_64-darwin" = "x86_64-apple-darwin";
        "aarch64-darwin" = "aarch64-apple-darwin";
      }.${
        stdenvNoCC.hostPlatform.system
      };
  in
    fetchzip {
      url = "https://github.com/unhappychoice/${finalAttrs.pname}/releases/download/v${finalAttrs.version}/${finalAttrs.pname}-v${finalAttrs.version}-${platform}.tar.gz";
      hash =
        {
          "x86_64-darwin" = "sha256-RiZW20wK2sqY9daIhUyKxboKrVh72XhvnwiDOtYfdl0=";
          "aarch64-darwin" = lib.fakeSha256;
        }.${
          stdenvNoCC.hostPlatform.system
        };
    };

  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ./gittype $out/bin/
    chmod +x $out/bin/gittype

    runHook postInstall
  '';

  meta = {
    description = "A CLI tool to practice typing git commands";
    homepage = "https://github.com/unhappychoice/gittype";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "gittype";
  };
})
