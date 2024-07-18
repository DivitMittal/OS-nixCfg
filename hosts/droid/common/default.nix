{ config, lib, pkgs, ... }:

{
  imports = [
    ./../../common
  ];

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

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";
}