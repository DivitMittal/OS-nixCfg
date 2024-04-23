_:

{
  imports = [
    ./nix.nix
    ./nixpkgs.nix
  ];

  time.timeZone = "Asia/Calcutta";

  environment = {
    systemPackages = builtins.attrValues {
      inherit(pkgs)
        nixfmt-rfc-style                                                                     # Nix goodies
        bashInteractive zsh dash fish babelfish                                              # shells
        bc diffutils findutils inetutils gnugrep gawk groff which gzip gnupatch gnutar  wget # GNU
        ed gnused vim                                                                        # editors
        curl git less;                                                                       # Other
    };
    extraOutputsToInstall = [ "dev" "info" "devdoc" ];
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

  environment = {
    shells = with pkgs;[bashInteractive zsh dash fish];
  };
}