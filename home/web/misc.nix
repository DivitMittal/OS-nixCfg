{pkgs, ...}: {
  # home.packages = lib.attrsets.attrValues {
  #   inherit
  #     (pkgs)
  #   #w3m
  #   #browsh
  #     ;
  # };

  programs.chawan = {
    enable = true;
    package = pkgs.chawan;
    settings = {
      buffer = {
        images = true;
        autofocus = true;
      };
    };
  };
}