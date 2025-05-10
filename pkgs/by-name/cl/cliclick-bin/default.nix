{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "cliclick-bin";
  version = "5.1";

  src = fetchurl {
    url = "https://github.com/BlueM/cliclick/releases/download/${version}/cliclick.zip";
    hash = "sha256-cQkQ/S2t5qO1iJWUv8AZ59TCvu4J/Xd1A+ceqCrMkbw=";
  };

  nativeBuildInputs = [unzip];

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin
    cp cliclick $out/bin/
    chmod +x $out/bin/cliclick
  '';

  meta = {
    description = "MacOS CLI tool for emulating mouse and keyboard events";
    homepage = "https://github.com/BlueM/cliclick";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [DivitMittal];
    mainProgram = "cliclick";
    platforms = lib.platforms.darwin;
  };
}