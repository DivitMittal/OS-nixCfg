{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages =
    lib.optionals hostPlatform.isDarwin [
      pkgs.brewCasks.mullvad-browser
      pkgs.brewCasks.tor-browser
    ]
    ++ lib.optionals (hostPlatform.system == "x86_64-linux") [
      pkgs.mullvad-browser
      pkgs.tor-browser
    ]
    ++ lib.optionals (hostPlatform.system == "i686-linux") [
      pkgs.tor-browser
    ];
}
