{ config, pkgs, user, hostPlatform, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      skate
      age
      # bitwarden-cli
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
      pinentry = (if hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry);
    };
  };
}