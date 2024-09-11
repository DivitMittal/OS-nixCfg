{ lib, pkgs, ... }:

let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "CascadiaCode"
    ];
  };
in
{
  imports = [
    ./../common
    ./macOS-defaults
    ./services
    ./homebrew.nix
  ];

  config = {
    nix.settings = {
      trusted-users = [ "root" "div" ];
    };

    environment.darwinConfig = "$HOME/OS-nixCfg/hosts/darwin/div-mbp/default.nix";

    networking = {
      computerName = "L1";
      hostName = "div-mbp";
    };

    fonts.packages = [ nerdfonts ];

    users.users.div = {
      description = "Divit Mittal";
      home = "/Users/div";
      shell = pkgs.fish;

      # Packages common to only instances of div-mbp & not all macOS hosts & installed in nix-darwin profile
      packages = builtins.attrValues {
        inherit(pkgs)
          duti
          blueutil
        ;
      };
    };
  };
}