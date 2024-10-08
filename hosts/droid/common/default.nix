{ config, username, hostname, lib, pkgs, ... }:

let
  inherit(lib) mkOption;
in
{
  options = let inherit(lib) types; in {
    paths.repo = mkOption {
      type = types.str;
      default = "/home/${username}/OS-nixCfg";
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
    environment.packages = builtins.attrValues {
      inherit(pkgs)
        bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg # GNU
        curl vim git uutils-coreutils-noprefix
        utillinux tzdata hostname openssh
      ;
    };

    time.timeZone = "Asia/Calcutta";

    environment.etcBackupExtension = ".bak";

    system.stateVersion = "24.05";
  };
}