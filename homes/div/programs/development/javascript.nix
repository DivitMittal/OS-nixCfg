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
}