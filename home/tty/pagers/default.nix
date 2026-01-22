{
  lib,
  pkgs,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home.sessionVariables.PAGER = "${pkgs.less}/bin/less";
}
