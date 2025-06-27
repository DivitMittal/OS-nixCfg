{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit (pkgs) nodejs;
    inherit (pkgs.nodePackages_latest) pnpm;
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
