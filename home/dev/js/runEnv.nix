{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    nodejs = pkgs.nodejs;
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
}