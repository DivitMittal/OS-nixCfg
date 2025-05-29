{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  environment.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      dash
      ;
  };

  user.shell = "${pkgs.fish}/bin/fish";
}
