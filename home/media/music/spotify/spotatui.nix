{
  inputs,
  hostPlatform,
  ...
}: {
  programs.spotatui = {
    enable = true;
    package = inputs.spotatui.packages.${hostPlatform.system}.default;
    settings = {
      enable_global_song_count = false;
      behavior.enable_discord_rpc = false;
    };
  };
}
