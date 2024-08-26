{ pkgs, ... }:

{
  imports = [
    ./nixCfg.nix
    ./shells.nix
  ];

  time.timeZone = "Asia/Calcutta";

  # packages common to all hosts & to be installed in OS-level nix profile
  environment.systemPackages = builtins.attrValues {
    inherit(pkgs)
      nixfmt-rfc-style                                                                  # Nix goodies
      bc diffutils findutils gnugrep inetutils which gzip gnutar wget gnupatch gnupg    # GNU
      curl git uutils-coreutils-noprefix;                                               # Other
  };

  documentation = {
    enable      = true;

    doc.enable  = true;
    info.enable = true;
    man.enable  = true;
  };
  environment.extraOutputsToInstall = [ "dev" "info" "devdoc" ];

  programs = {
    man.enable  = true;
    info.enable = true;
  };
}