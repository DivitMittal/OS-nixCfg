{
  lib,
  pkgs,
  hostPlatform,
  ...
}: {
  home.packages = lib.optionals pkgs.stdenvNoCC.hostPlatform.isDarwin [
    pkgs.customDarwin.nomacs-bin
  ];

  home.activation = lib.mkIf hostPlatform.isDarwin {
    importNomacsSettings = lib.hm.dag.entryAfter ["installPackages"] ''
      if command -v nomacs >/dev/null 2>&1; then
        $DRY_RUN_CMD ${pkgs.customDarwin.nomacs-bin}/bin/nomacs --import-settings ${./nomacs-settings.ini}
        echo "Imported nomacs settings"
      fi
    '';
  };
}
