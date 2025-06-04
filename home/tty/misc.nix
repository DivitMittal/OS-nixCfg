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

}