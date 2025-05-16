{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [inputs.nix-index-database.hmModules.nix-index];
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
    enableNushellIntegration = false;
  };

  programs.nix-init = {
    enable = true;
    package = pkgs.nix-init;
    settings = {
      maintainers = [
        config.hostSpec.handle
      ];
      commit = true;
      nixpkgs = "<nixpkgs>";
    };
  };

  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      nurl
      ;
  };
}
