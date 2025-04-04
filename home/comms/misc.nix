{
  pkgs,
  mypkgs,
  hostPlatform,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ## Discord
      #discord #discordo

      ## Matrix
      #element-desktop
      #gomuks

      ## Telegram
      #telegram-desktop
      ;

    whatsapp =
      if hostPlatform.isDarwin
      then mypkgs.whatsapp-for-mac
      else null;
  };
}