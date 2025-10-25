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

  user = rec {
    uid = 10660;
    gid = uid;
    shell = "${pkgs.fish}/bin/fish";
  };
}
