{
  pkgs,
  hostPlatform,
  lib,
  ...
}: let
  chrome = pkgs.brewCasks.google-chrome.overrideAttrs (oldAttrs: {
    src = pkgs.fetchurl {
      url = lib.lists.head oldAttrs.src.urls;
      hash = "sha256-4lf5x1Gg+TsMI86tj32EjCgI9V1l8oSQmuJJC3VOHTw=";
    };
  });
in {
  programs.chromium = {
    enable = false;
    package =
      if hostPlatform.isDarwin
      then chrome
      else pkgs.chromium;
    # extensions = lib.attrsets.attrValues {
    #   ublock-origin-lite = { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; };
    # };
  };
}
## Flags
# Override software redering list
# GPU rasterization
# Parallel downloading
# Experimental QUIC protocol

