{
  lib,
  pkgs,
  inputs,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    telegram-tui = inputs.tgt.packages.${hostPlatform.system}.default;
    inherit
      (pkgs)
      gomuks # Matrix client TUI
      ;
  };

  programs.discordo = {
    enable = true;
    settings = {
      keybinds.guilds_tree = {
        up = "Up";
        down = "Down";
      };
      keybinds.messages_list = {
        select_up = "Up";
        select_down = "Down";
        scroll_up = "Ctrl+Up";
        scroll_down = "Ctrl+Down";
      };
    };
  };
}
