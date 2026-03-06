{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "option-analysis";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "harsh-vardhhan";
    repo = "option-analysis";
    rev = "a5f67d3a92aafb253b386d1d63b9255d122c3436";
    hash = "sha256-QOWZOvW9bqzFxZkUaWB0+sUVruhq7rFlttAq3EcDLa4=";
  };

  cargoHash = "sha256-bIP40cfMNrekqXotKzfMZSb+sfoQQ0ybiLBBrrU8vUQ=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ];

  doCheck = false;

  meta = {
    description = "Trakbit - Keyboard-first options analytics tool for Indian markets";
    homepage = "https://github.com/harsh-vardhhan/option-analysis";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [DivitMittal];
    mainProgram = "option-analysis";
  };
}
