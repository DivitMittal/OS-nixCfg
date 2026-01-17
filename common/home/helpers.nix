{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    inputs.direnv-instant.homeModules.direnv-instant
  ];

  programs.nix-index-database.comma.enable = true;
  programs.nix-index = {
    enable = true;
    package = pkgs.nix-index;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.nix-your-shell = {
    enable = true;
    package = pkgs.nix-your-shell;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.nix-init = {
    enable = true;
    package = pkgs.nix-init;
    settings = {
      maintainers = [config.hostSpec.handle];
      commit = true;
      nixpkgs = "<nixpkgs>";
    };
  };

  programs.nix-search-tv = {
    enable = true;
    package = pkgs.nix-search-tv;
    enableTelevisionIntegration = true;
  };

  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = false;

    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };

  programs.direnv-instant = {
    enable = false;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      mux_delay = 10; # delay in seconds before starting the multiplexer
    };
  };

  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      nurl
      nix-melt
      nix-tree
      cachix
      ;
  };

  ## documentation
  programs.man = {
    enable = true;
    package = pkgs.man;
    generateCaches = false; # Cache generation disabled to reduce rebuild time (used for whatis/apropos commands)
  };
  programs.info.enable = true;
  home.extraOutputsToInstall = ["info"]; # "doc" "devdoc"
}
