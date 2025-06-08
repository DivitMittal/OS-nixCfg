{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = lib.lists.optionals config.xdg.configFile."ideavim/ideavimrc".enable [pkgs.brewCasks.pycharm];

  xdg.configFile."ideavim/ideavimrc" = {
    enable = false;
    source = ./ideavimrc;
  };
}