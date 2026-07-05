{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages =
    # Platform-native service-supervisor TUIs:
    #   Darwin → launchd + Homebrew services (launchdeck-bin)
    #   Linux  → systemd units + logs        (systemctl-tui)
    (lib.optionals hostPlatform.isDarwin [
      pkgs.customDarwin.launchdeck-bin
      pkgs.custom.uniclipboard-cli-bin
    ])
    ++ lib.optionals hostPlatform.isLinux [
      pkgs.systemctl-tui
      pkgs.bluetui # bluetooth service/device manager
      pkgs.custom.uniclipboard-cli-bin
    ];
}
