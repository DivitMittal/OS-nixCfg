{
  lib,
  rustPlatform,
  fetchFromGitHub,
  perl,
}:
rustPlatform.buildRustPackage {
  pname = "dmgwiz";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "citruz";
    repo = "dmgwiz";
    rev = "v1.1.0";
    hash = "sha256-8iuucOOLKd9WoFEFwn5xP1ZZ2C1GAQeyVO6mSdDYb8Y=";
  };

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
