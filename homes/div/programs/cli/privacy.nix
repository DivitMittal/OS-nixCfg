{ config, pkgs, pkgs-darwin, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
  pinentryPackage = if isDarwin then pkgs-darwin.pinentry_mac else pkgs.pinentry;
in
{
  home.packages = builtins.attrValues {
    bw = if isDarwin then pkgs-darwin.bitwarden-cli else pkgs.bitwarden-cli;
    age = pkgs.age;
  };

  programs.gpg = {
    enable = true;
    package = if isDarwin then pkgs-darwin.gnupg else pkgs.gnupg;

    homedir = "${config.xdg.dataHome}/gnupg";

    settings = {
      no-comments = false;
      s2k-cipher-algo = "AES128";
    };
  };

  programs.rbw = {
    enable = true;
    package = if isDarwin then pkgs-darwin.rbw else pkgs.rbw;

    settings = {
      email = "mittaldivit@gmail.com";
      pinentry = pinentryPackage;
    };
  };
}