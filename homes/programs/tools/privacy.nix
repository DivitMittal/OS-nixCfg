{ config, pkgs, user, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      skate
      # bitwarden-cli
      # age = pkgs.age;
    ;
  };

  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;

    homedir = "${config.xdg.dataHome}/gnupg";

    settings = {
      no-comments = false;
      s2k-cipher-algo = "AES128";
    };
  };

  programs.rbw = {
    enable = false;
    package = pkgs.rbw;

    settings = {
      email = builtins.elemAt user.emails 1;
      pinentry = (if isDarwin then pkgs.pinentry_mac else pkgs.pinentry);
    };
  };
}