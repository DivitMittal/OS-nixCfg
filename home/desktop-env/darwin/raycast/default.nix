{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      raycast
    ;
  };

  xdg.configFile."raycast/scripts" = {
    enable = true;
    source = ./scripts;
    recursive = true;
  };
}