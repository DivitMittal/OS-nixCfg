{ pkgs, ... }:

{
  environment.darwinConfig = "$HOME/sync-darwin/hosts/darwin/div-mbp/default.nix";

  networking = {
    computerName = "L1";
    hostName     = "div-mbp";
  };

  fonts = {
    fontDir.enable = true;
    fonts          = with pkgs;[(nerdfonts.override {fonts = ["CascadiaCode"];})];
  };

  users = {
    users.div = {
      description = "Divit Mittal";
      home        = "${if pkgs.stdenvNoCC.isDarwin then "/Users" else "/home"}/div";
      shell       = pkgs.fish;
      packages    = builtins.attrValues {
        inherit(pkgs)
          # macOS utils
          ruby duti blueutil
          yabai skhd jq;
        coreutils = pkgs.uutils-coreutils.override {prefix = "";};
      };
    };
  };

  imports = [
    ./../common
    ./mac.nix
    ./programs/sh.nix
    ./services/yabai.nix
    ./services/skhd.nix
    ./homebrew.nix
  ];
}