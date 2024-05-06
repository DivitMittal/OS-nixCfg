{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./nixpkgs.nix
    ./shells.nix
    ./programs
  ];

  time.timeZone = "Asia/Calcutta";

  environment = {
    systemPackages = builtins.attrValues {
      inherit(pkgs)
        nixfmt-rfc-style                                                                     # Nix goodies
        bashInteractive zsh dash fish babelfish                                              # shells
        bc diffutils findutils gnugrep inetutils groff which gzip gnupatch gnutar wget       # GNU
        ed gnused vim gawk                                                                   # editors
        curl git less;                                                                       # Other
      coreutils = pkgs.uutils-coreutils.override {prefix = "";};
    };

    extraOutputsToInstall = [ "dev" "info" "devdoc" ];

    shells = with pkgs;[bashInteractive zsh dash fish];
  };

  documentation = {
    enable      = true;
    doc.enable  = true;
    info.enable = true;
    man.enable  = true;
  };

  programs = {
    nix-index.enable = true;
    man.enable       = true;
    info.enable      = true;
  };
}