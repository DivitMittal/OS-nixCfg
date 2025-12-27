{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mole";
  version = "1.14.7";

  src = fetchFromGitHub {
    owner = "tw93";
    repo = "Mole";
    rev = "V${finalAttrs.version}";
    hash = "sha256-zmc3o9Rt5yAIjz7aSbEPsuoOVkOEoHWcOhbeOzpbchY=";
  };

  installPhase = ''
    runHook preInstall

    # Install everything to maintain directory structure
    mkdir -p $out/bin
    cp -r lib $out/bin/
    cp mole mo $out/bin/
    chmod +x $out/bin/mole $out/bin/mo

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
