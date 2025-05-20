{
  pkgs,
  self,
  lib,
  ...
}: {
  environment.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      dash
      ;
  };

  user.shell = "${pkgs.fish}/bin/fish";

  home-manager = {
    config = builtins.import ./home;
    extraSpecialArgs = {
      inherit self;
    };
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
  };
}