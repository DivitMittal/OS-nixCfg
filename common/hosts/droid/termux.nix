{pkgs, ...}: {
  ## Termux settings
  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
  };
  terminal = {
    colors = {
      background = "#000000";
      foreground = "#FFFFFF";
      cursor = "#FF0000";
    };
    font = "${pkgs.nerd-fonts.caskaydia-cove}/share/fonts/truetype/NerdFonts/CaskaydiaCoveNerdFontMono-Regular.ttf";
  };
}
