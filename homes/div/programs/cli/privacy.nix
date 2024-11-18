{ config, pkgs, pkgs-darwin, ... }:

{
  home.packages = builtins.attrValues {
    bw = if pkgs.stdenvNoCC.hostPlatform.isDarwin then pkgs-darwin.bitwarden-cli else pkgs.bitwarden-cli;
    age = pkgs.age;
    pinentry = pkgs-darwin.pinentry_mac;
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

  # disabled
  programs.rbw = {
    enable = true;
    package = pkgs-darwin.rbw;

    settings = {
      email = "mittaldivit@gmail.com";
      pinentry = pkgs.pinentry_mac;
    };
  };
}