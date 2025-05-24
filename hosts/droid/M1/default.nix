{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home
  ];

  environment.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      dash
      ;
  };

  user.shell = "${pkgs.fish}/bin/fish";
}
