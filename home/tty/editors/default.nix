{lib, ...}: {
  imports = lib.custom.scanPaths ./.;

  home.sessionVariables.EDITOR = "nvim";
}
