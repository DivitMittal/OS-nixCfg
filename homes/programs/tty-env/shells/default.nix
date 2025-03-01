{ pkgs, config,... }:

{
  imports = [
    ./common.nix
    ./fish.nix
    ./zsh.nix
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;

    # All interactive sessions
    initExtra = ''
      export BADOTDIR="${config.xdg.configHome}/bash"
      export HISTFILE="''${BADOTDIR:-$HOME}/.bash_history"

      # vi keybindings
      set -o vi
    '';
  };

  home.packages = builtins.attrValues {
    powershell = pkgs.powershell;
  };

  programs.nushell = {
    enable = true;
    package = pkgs.nushell;

    configFile.text = ''
      $env.config = {
        show_banner: false,
      }
    '';
  };

  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    enableBashIntegration = true;
    # enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
}