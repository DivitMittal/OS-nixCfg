{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [inputs.nix-index-database.homeModules.nix-index];

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
    enableBashIntegration = false;
    # enableFishIntegration = false;
    enableZshIntegration = false;
    enableNushellIntegration = false;

    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
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
    direnv-instant = inputs.direnv-instant.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  ## documentation
  programs.man = {
    enable = true;
    package = pkgs.man;
    generateCaches = true;
  };
  programs.info.enable = true;
  home.extraOutputsToInstall = ["info"]; # "doc" "devdoc"
}
