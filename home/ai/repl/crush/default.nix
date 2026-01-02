{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  programs.crush = {
    enable = false;
    package = pkgs.ai.crush;
  };
}
