{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./nixpkgs.nix
    ./shells.nix
    ./programs
  ];

  time.timeZone = "Asia/Kolkata";

  environment = {
    systemPackages = builtins.attrValues {
      inherit(pkgs)
        nixfmt-rfc-style                                                                     # Nix goodies
        bashInteractive zsh dash fish babelfish                                              # shells
        bc diffutils findutils inetutils gnugrep gawk groff which gzip gnupatch gnutar wget  # GNU
        ed gnused vim                                                                        # editors
        curl git less;                                                                       # Other
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