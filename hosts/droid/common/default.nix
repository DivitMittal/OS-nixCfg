{ config, lib, pkgs, ... }:

{

  environment.packages = builtins.attrValues {
    inherit(pkgs)
    # vim
    # diffutils findutils
    utillinux tzdata hostname
    # man
    # gnugrep
    # gnupg
    #gnused #gnutar #bzip2 #gzip #xz #zip #unzip
    fastfetch
    openssh;
  };

  time.timeZone =

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";
}