{ config, username, hostname, lib, pkgs, ... }:

let
  inherit(lib) mkOption;
  cfg = config.path;
in
{
  options = let inherit(lib) types; in {
    paths.repo = mkOption {
      type = types.path;
      default = /home/${username}/OS-nixCfg;
      description = "Path to the main repo containing nix-on-droid & other nix configs";
    };

    paths.currentDroidCfg = mkOption {
      type = types.path;
      default = ${cfg.repo}/hosts/droid/${hostname};
      description = "Path to darwin configs";
    };

    paths.secrets = mkOption {
      type = types.path;
      default = ${cfg.repo}/secrets;
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

    environment.etcBackupExtension = ".bak";
    system.stateVersion = "24.05";
  };
}