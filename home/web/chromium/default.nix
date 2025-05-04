{
  pkgs,
  hostPlatform,
  ...
}: let
  chrome = pkgs.brewCasks.google-chrome.overrideAttrs (oldAttrs: {
    src = pkgs.fetchurl {
      url = builtins.head oldAttrs.src.urls;
      hash = "sha256-z4S/hzDPOTNtS3r7rSsACpW+pP3t8KEOVPODp7DcW2Q=";
    };
  });
in {
  programs.chromium = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then chrome
      else pkgs.chromium;
    # extensions = builtins.attrValues {
    #   ublock-origin-lite = { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; };
    # };
  };
}