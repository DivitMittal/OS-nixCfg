{ pkgs, ... } :

{
  environment.packages = builtins.attrValues {
    inherit(pkgs)
      dash
    ;
  };

  user.shell = "${pkgs.fish}/bin/fish";

  home-manager = {
    config = import ./home;
    # extraSpecialArgs = {
    #   repo = "${config.user.home}/OS-nixCfg";
    # };
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
  };
}