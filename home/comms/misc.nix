_: {
  home.packages = builtins.attrValues {
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

    # whatsapp =
    #   if hostPlatform.isDarwin
    #   then pkgs.brewCasks.whatsapp
    #   else null;
  };
}
