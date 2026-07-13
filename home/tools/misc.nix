{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ttyper
      ;
  };

  programs.wiki-tui = {
    enable = true;
    package = pkgs.wiki-tui;

    settings = {
      bindings.global = {
        scroll_down = "down";
        scroll_up = "up";
      };
    };
  };
}
