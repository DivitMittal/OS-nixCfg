{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mole";
  version = "1.27.0";

  src = fetchFromGitHub {
    owner = "tw93";
    repo = "Mole";
    rev = "V${finalAttrs.version}";
    hash = "sha256-7a5oQfJJIESjit+gl7FrbkT5wptxBhhWuTLCpULlQ6w=";
  };

  # Fix bash arithmetic bug: ((var++)) returns exit code 1 when var=0
  # which causes early exit with set -e. Using : $((var++)) always succeeds.
  postPatch = ''
    find . -name '*.sh' -exec sed -i 's/((\([a-z_]*\)++))/: $((\1++))/g' {} +
  '';

  dontBuild = true; # No need to build, all scripts are in the source

  installPhase = ''
    runHook preInstall

    # Install main executables to bin
    mkdir -p $out/bin
    cp mole mo $out/bin/
    chmod +x $out/bin/mole $out/bin/mo

    # Install lib and bin directories to share/mole
    # Includes bin/ directory with all necessary shell scripts
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
