{ pkgs, self, ... } :

{
  environment.packages = builtins.attrValues {
    inherit(pkgs)
      dash
    ;
  };

  user.shell = "${pkgs.fish}/bin/fish";

  home-manager = {
    config = import ./home;
    extraSpecialArgs = {
      inherit self;
    };
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
  };
}