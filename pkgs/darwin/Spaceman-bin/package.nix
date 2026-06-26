{
  stdenvNoCC,
  lib,
  sources,
  _7zz,
  ...
}:
stdenvNoCC.mkDerivation (_finalAttrs: {
  pname = "Spaceman";
  inherit (sources.Spaceman) version src;

  nativeBuildInputs = [_7zz];

  unpackPhase = ''7zz x -snld $src'';

  sourceRoot = "Spaceman.app";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/Spaceman.app"
    cp -R . "$out/Applications/Spaceman.app"

    runHook postInstall
  '';

  meta = {
    description = "Display macOS Spaces in the menu bar";
    homepage = "https://github.com/ruittenb/Spaceman";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
