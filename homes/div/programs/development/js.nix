{ pkgs, pkgs-darwin, config, ... }:


{
  home.packages = builtins.attrValues {
    nodejs = if pkgs.stdenvNoCC.hostPlatform.isDarwin then pkgs-darwin.nodejs_22 else pkgs.nodejs_22;
    pnpm = pkgs.nodePackages_latest.pnpm;
  };

  programs.bun = {
    enable = true;
    package = pkgs.bun;

    enableGitIntegration = true;

    settings = {
      telemetry = false;
    };
  };

  # JSON
  programs.jq = {
    enable = true;
    package = pkgs.jq;

    colors = {
      null = "1;30";
      false = "0;31";
      true = "0;32";
      numbers = "0;36";
      strings = "0;33";
      arrays = "1;35";
      objects = "1;37";
    };
  };
}