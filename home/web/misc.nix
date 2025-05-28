{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      lynx
      #w3m
      #elinks
      #browsh links2
      ;
  };

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
