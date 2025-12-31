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
    # Wrap television to use bash as default shell for shell-specific commands
    package = pkgs.symlinkJoin {
      name = "television-wrapped";
      paths = [pkgs.television];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/tv \
          --set SHELL ${pkgs.bash}/bin/bash
      '';
    };
    # Disable all shell integrations to avoid keybinding conflicts with atuin (ctrl-r) and file completion (ctrl+t)
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;
  };
}
