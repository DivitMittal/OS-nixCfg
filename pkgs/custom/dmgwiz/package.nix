{
  lib,
  rustPlatform,
  sources,
  perl,
}:
rustPlatform.buildRustPackage {
  pname = "dmgwiz";
  version = lib.removePrefix "v" sources.dmgwiz.version;

  inherit (sources.dmgwiz) src;

  cargoHash = "sha256-3W+61+1wZWI+s9XVl74cp/8bb+UUuqlqAo/cxV7WbEk=";

  nativeBuildInputs = [perl];

  meta = {
    description = "Extract filesystem data from DMG files";
    homepage = "https://github.com/citruz/dmgwiz";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [DivitMittal];
    mainProgram = "dmgwiz";
  };
}
