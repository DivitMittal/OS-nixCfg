{ config, lib, pkgs, ... }:

{
  imports = [
    ./ssh.nix
  ];

  options = let inherit(lib) mkOption types; in {
    paths.repo = mkOption {
      type = types.str;
      default = "${config.user.home}/OS-nixCfg";
      description = "Path to the main repo containing nix-on-droid & other nix configs";
    };

    paths.homes = mkOption {
      type = types.str;
      default = "${config.paths.repo}/homes";
      description = "Path to secrets";
    };

    paths.secrets = mkOption {
      type = types.str;
      default = "${config.paths.repo}/secrets";
      description = "Path to secrets";
    };
  };

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
        bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg # GNU
        curl vim uutils-coreutils-noprefix #git
        utillinux tzdata hostname openssh
      ;
    };

    environment.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

    environment.etcBackupExtension = ".bak";
    system.stateVersion = "24.05";
  };
}