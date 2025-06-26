{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      wiki-tui
      ;
  };

  programs.fish.functions = {
    cht = "curl -ssL https://cheat.sh/$argv | ${pkgs.bat}/bin/bat";
  };

  programs.tealdeer = {
    enable = true;
    package = pkgs.tealdeer;

    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {
        auto_update = true;
        auto_update_interval_hours = 240;
      };
    };
  };
}