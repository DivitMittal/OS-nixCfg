{
  pkgs,
  inputs,
  ...
}: let
  TLTR = pkgs.fetchFromGitHub {
    owner = "DivitMittal";
    repo = "TLTR";
    rev = "1af4f80b9ec9b8f2c8f55b66ecdf30ebc2fc162d";
    hash = "sha256-HeS4M+AQEghl9DxoUAiYpEkQ9Ar47KJjrdWMJXHUA/A=";
  };
in {
  home.packages = [pkgs.kanata-with-cmd];

  imports = [
    inputs.kanata-tray.homeManagerModules.kanata-tray
    (import ./kanata-tray.nix {
      inherit pkgs;
      inherit TLTR;
    })
  ];

  xdg.configFile."karabiner" = {
    enable = false;
    source = "${TLTR}/karabiner";
    recursive = true;
  };
}
