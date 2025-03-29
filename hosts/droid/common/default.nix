{ pkgs, lib, ... }:

{
  imports = lib.custom.scanPaths ./.;

  config = {
    time.timeZone = "Asia/Calcutta";

    environment.motd = "";

    android-integration = {
      am.enable = true;
      termux-open.enable = true;
      termux-open-url.enable = true;
      termux-reload-settings.enable = true;
      termux-setup-storage.enable = true;
    };

    terminal = {
      colors = {
        background = "#000000";
        foreground = "#FFFFFF";
        cursor = "#FF0000";
      };
      font =  "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/CaskaydiaCoveNerdFontMono-Regular.ttf";
    };

    environment.packages = builtins.attrValues {
      inherit(pkgs)
        bc gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg # GNU
        curl vim uutils-coreutils-noprefix uutils-diffutils uutils-findutils #git
        utillinux tzdata hostname openssh
      ;
    };

    environment.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

    environment.etcBackupExtension = ".bak";
    system.stateVersion = "24.05";
  };
}