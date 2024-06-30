{ lib, pkgs, ... }:

{
  imports = [
    ./../common
    ./services
    ./macOS.nix
    ./homebrew.nix
  ];

  nix.settings = {
    trusted-users = ["root" "div"];
  };

  environment.darwinConfig = "$HOME/OS-nixCfg/hosts/darwin/div-mbp/default.nix";

  networking = {
    computerName = "L1";
    hostName     = "div-mbp";
  };

  fonts = {
    packages = with pkgs;[
      (nerdfonts.override { fonts = ["CascadiaCode"]; })
    ];
  };

  users = {
    users.div = {
      description = "Divit Mittal";
      home        = "/Users/div";
      shell       = pkgs.fish;
      packages    = builtins.attrValues {
        inherit(pkgs)
          duti blueutil;
      };
    };
  };
}