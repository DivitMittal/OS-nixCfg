{
  pkgs,
  lib,
  ...
}: let
  enable = false;
in {
  home.packages = lib.lists.optionals enable [pkgs.brewCasks.pycharm];

  xdg.configFile."ideavim/ideavimrc" = {
    inherit enable;
    source = ./ideavimrc;
  };
}