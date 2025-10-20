{pkgs, ...}: {
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
