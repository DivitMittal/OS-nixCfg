{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      fselect # SQL find
      ;
  };

  programs.fd = {
    enable = true;
    package = pkgs.fd;
    hidden = true; # creates shell alias
  };

  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;

    enableFishIntegration = config.programs.fish.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = false;
    enableNushellIntegration = false;
    options = ["--cmd cd"];
  };

  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep;

    arguments = [
      "-i"
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };

  programs.ripgrep-all = {
    enable = true;
    package = pkgs.ripgrep-all;
  };

  programs.television = {
    enable = true;
    package = pkgs.television;
    enableBashIntegration = false;
    enableZshIntegration = config.programs.zsh.enable;
    enableFishIntegration = config.programs.fish.enable;
  };
}
