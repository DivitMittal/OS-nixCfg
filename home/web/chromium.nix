{
  pkgs,
  hostPlatform,
  lib,
  ...
}: let
  chrome = pkgs.brewCasks.google-chrome.overrideAttrs (oldAttrs: {
    src = pkgs.fetchurl {
      url = lib.lists.head oldAttrs.src.urls;
      hash = "sha256-R/k9gdOthgiME1/zK+6qQ6oqNgHme76iTkybVVFSU9I=";
    };
  });
in {
  programs.chromium = {
    enable = true;
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

