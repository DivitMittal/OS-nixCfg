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
      then pkgs.brewCasks.ungoogled-chromium.override {variation = "tahoe";}
      else pkgs.chromium;

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
