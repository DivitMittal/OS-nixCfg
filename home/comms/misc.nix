{
  lib,
  pkgs,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # inherit(pkgs)
    #   ## Discord
    #   #discord #discordo
    #
    #   ## Matrix
    #   #element-desktop
    #   #gomuks
    #
    #   ## Telegram
    #   #telegram-desktop
    #   ;

    whatsapp =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.whatsapp
      else null;
  };
}
