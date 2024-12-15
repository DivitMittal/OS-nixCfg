{ pkgs, ... }:

{
  imports = [
    ./file
    ./multiplexers
    ./pagers
    ./shells
    ./atuin.nix
    ./eza.nix
    ./fastfetch.nix
    ./starship.nix
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      grc
      duf
      dust
    ;
  };

  programs.thefuck = {
    enable = true;
    package = pkgs.thefuck;

    enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false; enableNushellIntegration = false;
  };

  programs.tealdeer = {
    enable = true;

    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {
        auto_update = true;
        auto_update_interval_hours = 240;
      };
    };
  };
}