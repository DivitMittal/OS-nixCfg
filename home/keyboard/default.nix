{
  pkgs,
  lib,
  ...
}: let
  TLTR = pkgs.fetchFromGitHub {
    owner = "DivitMittal";
    repo = "TLTR";
    rev = "1af4f80b9ec9b8f2c8f55b66ecdf30ebc2fc162d";
    hash = "sha256-HeS4M+AQEghl9DxoUAiYpEkQ9Ar47KJjrdWMJXHUA/A=";
  };
in {
  _module.args = {
    inherit TLTR;
  };
  imports = lib.custom.scanPaths ./.;

  home.packages = [pkgs.kanata-with-cmd];

  # xdg.configFile."karabiner" = {
  #   enable = true;
  #   source = "${TLTR}/karabiner";
  #   recursive = true;
  # };
}
