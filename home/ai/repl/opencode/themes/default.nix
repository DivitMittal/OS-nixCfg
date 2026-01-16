{config, ...}: {
  xdg.configFile."opencode/themes/ultraviolet.json" = {
    inherit (config.programs.opencode) enable;
    source = ./ultraviolet.json;
  };

  programs.opencode.settings.theme = "ultraviolet";
}
