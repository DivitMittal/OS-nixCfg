{ config, lib, pkgs, ... }:

{
  options = {
    paths.secrets = lib.mkOption {
      type = lib.types.str;
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