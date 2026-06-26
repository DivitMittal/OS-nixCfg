{
  inputs,
  hostPlatform,
  pkgs,
  ...
}: {
  programs.spotatui = {
    enable = true;
    package = inputs.spotatui.packages.${hostPlatform.system}.default.overrideAttrs (old: {
      cargoDeps = pkgs.rustPlatform.importCargoLock {
        lockFile = "${old.src}/Cargo.lock";
        outputHashes = {
          "librespot-audio-0.8.0" = "sha256-WejAb0fSLxAGJw3in1kpL3fEvTToUhvYwIaXJxN8BV4=";
        };
      };
    });
    settings = {
      enable_global_song_count = false;
      behavior = {
        enable_discord_rpc = false;
        enable_announcements = false;
      };
    };
  };
}
