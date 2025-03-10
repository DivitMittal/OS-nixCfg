{ pkgs, config, ... } :

{
  environment.packages = builtins.attrValues {
    inherit(pkgs)
      dash
    ;
  };

  user.shell = "${pkgs.zsh}/bin/zsh";

  home-manager = {
    config = import ./home.nix;
    extraSpecialArgs = {
      repo = "${config.user.home}/OS-nixCfg";
    };
    backupFileExtension = ".bak";
  };
}