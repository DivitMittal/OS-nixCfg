{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  programs.chromium = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.chromium
      else pkgs.chromium;

    commandLineArgs = [
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-parallel-downloading"
      "--enable-quic"
    ];

    # Extensions only work with open-source Chromium (not Google Chrome)
    extensions = lib.optionals (!hostPlatform.isDarwin) [
      {id = "ddkjiahejlhfcafbddmgiahcphecmpfh";} # ublock-origin-lite
      {id = "hfjbmagddngcpeloejdejnfgbamkjaeg";} # vimiumC
    ];
  };
}
