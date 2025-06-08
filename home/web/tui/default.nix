{
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  # home.packages = lib.attrsets.attrValues {
  #   inherit
  #     (pkgs)
  #     #w3m
  #     #elinks
  #     #browsh links2
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
