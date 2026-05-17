{
  lib,
  rustPlatform,
  sources,
  pkg-config,
  openssl,
  ...
}:
rustPlatform.buildRustPackage {
  inherit (sources.option-analysis) pname src;
  version = "0.1.0";

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
