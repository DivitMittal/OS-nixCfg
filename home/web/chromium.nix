{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;

    commandLineArgs = lib.optionals (!hostPlatform.isDarwin) [
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
