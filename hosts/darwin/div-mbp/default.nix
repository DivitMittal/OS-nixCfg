{ lib, pkgs, ... }:

{
  nix.settings = {
    trusted-users = ["root" "div"];
  };

  environment.darwinConfig = "$HOME/sync-darwin/hosts/darwin/div-mbp/default.nix";

  networking = {
    computerName = "L1";
    hostName     = "div-mbp";
  };

  fonts = {
    fontDir.enable = true;
    fonts          = with pkgs;[
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
          duti blueutil jq;
      };
    };
  };

  imports = [
    ./../common
    ./services
    ./macOS.nix
    ./homebrew.nix
  ];
}