{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mole";
  version = "1.20.0";

  src = fetchFromGitHub {
    owner = "tw93";
    repo = "Mole";
    rev = "V${finalAttrs.version}";
    hash = "sha256-vYwhfRLSvK/S3lgG50R5aurB8bnLsPbsbM8TdHWvrjQ=";
  };

  dontBuild = true; # No need to build, all scripts are in the source

  installPhase = ''
    runHook preInstall

    # Install main executables to bin
    mkdir -p $out/bin
    cp mole mo $out/bin/
    chmod +x $out/bin/mole $out/bin/mo

    # Install lib and bin directories to share/mole
    # V1.20.0 includes bin/ directory with all necessary shell scripts
    mkdir -p $out/share/mole
    cp -r lib bin $out/share/mole/
    chmod +x $out/share/mole/bin/*.sh

    # Patch the mole script to use the correct SCRIPT_DIR
    substituteInPlace $out/bin/mole \
      --replace-fail 'SCRIPT_DIR="$(cd "$(dirname "''${BASH_SOURCE[0]}")" && pwd)"' \
                     'SCRIPT_DIR="'"$out/share/mole"'"'

    runHook postInstall
  '';

  meta = {
    description = "Deep clean and optimize your Mac";
    homepage = "https://github.com/tw93/Mole";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    mainProgram = "mo";
  };
})
