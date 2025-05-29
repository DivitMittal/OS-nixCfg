{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      grc
      duf
      dust
      cyme
      croc
      ;
  };

  # programs.thefuck = {
  #   enable = false;
  #   package = pkgs.thefuck;
  #
  #   enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false; enableNushellIntegration = false;
  # };
  programs.pay-respects = {
    enable = true;
    package = pkgs.pay-respects;

    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
    enableNushellIntegration = false;
  };

  programs.tealdeer = {
    enable = true;
    package = pkgs.tealdeer;

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