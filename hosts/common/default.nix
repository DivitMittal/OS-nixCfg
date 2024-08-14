{ pkgs, ... }:

{
  imports = [
    ./nixCfg.nix
    ./shells.nix
  ];

  time.timeZone = "Asia/Calcutta";

  environment.systemPackages = builtins.attrValues {
    inherit(pkgs)
      nixfmt-rfc-style                                                                  # Nix goodies
      bc diffutils findutils gnugrep inetutils which gzip gnutar wget gnupatch gnupg    # GNU
      vim
      curl git;                                                                         # Other
    coreutils = pkgs.uutils-coreutils.override {prefix = "";};
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