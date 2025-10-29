{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    outlook =
      if hostPlatform.isDarwin
      then
        (pkgs.brewCasks.microsoft-outlook.overrideAttrs (oldAttrs: {
          installPhase =
            oldAttrs.installPhase
            + ''
              # Clean Resources
              echo "Removing entire Resources directory from microsoft-outlook installation..."
              local resource_dir="$out/Resources"

              if [ -d "$resource_dir" ]; then
                echo "Found directory '$resource_dir' and removing it..."
                rm -rf "$resource_dir"
              else
                echo "Warning: Resources directory '$resource_dir' not found. It may have been removed already or path is wrong." >&2
              fi
              echo "Finished cleanup (removed Resources) for microsoft-outlook."
            '';
        }))
      else null;

    localsend =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.localsend
      else pkgs.localsend;

    whatsapp =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.whatsapp
      else null;

    # inherit
    #   (pkgs)
    #   #discord #discordo
    #   #telegram-desktop
    #   #element-desktop
    #   ;
  };
}
