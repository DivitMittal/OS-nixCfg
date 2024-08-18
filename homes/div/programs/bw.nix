{ pkgs, ... }:

{
  home.packages = with pkgs; [ bitwarden-cli ];

  programs.rbw = {
    enable = true;
    package = pkgs.rbw;

    settings = {
      email = "mittaldivit@gmail.com";
      pinentry = pkgs.pinentry_mac;
    };
  };
}
