{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit (pkgs) pnpm;
  };

  home.sessionVariables.PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  home.sessionPath = ["${config.home.sessionVariables.PNPM_HOME}"];

  # npm configuration
  programs.npm = {
    enable = true;
    package = pkgs.nodejs;
    settings = {
      fund = false; # Disable funding messages
      audit = false; # Disable audit warnings
    };
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
