{ config, lib, pkgs, ... }:

let
  inherit(lib) mkOption;
  hostname = "M1";
in
{
  imports = [
    ./ssh.nix
  ];

  options = let inherit(lib) types; in {
    paths.repo = mkOption {
      type = types.str;
      default = "${config.user.home}/OS-nixCfg";
      description = "Path to the main repo containing nix-on-droid & other nix configs";
    };

    paths.currentDroidCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/hosts/droid/${hostname}";
      description = "Path to darwin configs";
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
