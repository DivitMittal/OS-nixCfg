{ config, lib, pkgs, ... }:

{
  environment.packages = builtins.attrValues {
    inherit(pkgs)
      bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg # GNU
      curl vim git uutils-coreutils-noprefix;                                                    # Other
      utillinux tzdata hostname
      fastfetch
      openssh
    ;
  };

  time.timeZone =

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";
}