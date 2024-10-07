{ config, pkgs, pkgs-darwin, ... }:

{
  home.packages = builtins.attrValues {
    bw = if pkgs.stdenvNoCC.hostPlatform.isDarwin then pkgs-darwin.bitwarden-cli else pkgs.bitwarden-cli;
    age = pkgs.age;
  };

  programs.rbw = {
    enable = true;
    package = pkgs.rbw;

    settings = {
      email = "mittaldivit@gmail.com";
      pinentry = pkgs.pinentry_mac;
    };
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
}