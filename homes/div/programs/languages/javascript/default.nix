{ pkgs, config, ... }:


{
  home.packages = builtins.attrValues {
    nodejs = pkgs.nodejs_22;
    pnpm   = pkgs.nodePackages_latest.pnpm;
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