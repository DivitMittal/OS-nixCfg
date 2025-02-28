{ pkgs, ... }:

{
  imports = [
    ./editors
    ./file
    ./multiplexers
    ./pagers
    ./shells
    ./vcs
    ./atuin.nix
    ./btop.nix
    ./eza.nix
    ./fastfetch.nix
    ./starship.nix
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      grc
      duf
      dust
      sendme # Iroh protocol
    ;
  };

  # Using pay-respects instead
  # programs.thefuck = {
  #   enable = false;
  #   package = pkgs.thefuck;
  #
  #   enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false; enableNushellIntegration = false;
  # };
  programs.pay-respects = {
    enable = true;
    package = pkgs.pay-respects;

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