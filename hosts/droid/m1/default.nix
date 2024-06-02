{ pkgs, ... }:

{
  imports = [
    ./../common
    ./ssh.nix
  ];

  # nix.package  = lib.mkDefault pkgs.nixVersions.latest;
  # nix.extraOptions = '' experimental-features = nix-command flakes '';
  #
  # time.timeZone = "Asia/Calcutta";

  environment.packages = builtins.attrValues {
    inherit(pkgs)
    # vim
    # diffutils findutils
    utillinux tzdata hostname
    # man
    # gnugrep
    gnupg
    #gnused #gnutar #bzip2 #gzip #xz #zip #unzip
    fastfetch
    openssh;
  };

  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "23.11";
}