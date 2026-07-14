{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    mullvad-vpn =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.mullvad-vpn
      else pkgs.mullvad-vpn;
    tailscale =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.tailscale-app
      else pkgs.tailscale;
  };
}
