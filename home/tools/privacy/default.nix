{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      age
      #skate
      ;
  };

  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;

    homedir = "${config.xdg.dataHome}/gnupg";

    settings = {
      no-comments = false;
      s2k-cipher-algo = "AES128";
    };
  };
}
