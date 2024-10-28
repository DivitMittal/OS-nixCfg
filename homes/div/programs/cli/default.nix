{ pkgs, ... }:

{
  imports = [
    ./spicetify
    ./atuin.nix
    ./eza.nix
    ./fastfetch.nix
    ./privacy.nix
    ./rclone.nix
    ./ssh.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    duf
    dust
    grc

    # AI
    aichat

    # networking
    nmap speedtest-go
  ];

  programs.thefuck = {
    enable = true;
    package = pkgs.thefuck;

    enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false;
  };

  programs.aria2  = {
    enable = true;

    settings = {
      # listen-port = 60000;
      # dht-listen-port = 60000;
      # seed-ratio = 1.0;
      # max-upload-limit = "50K";
      ftp-pasv = true;
    };
  };

  programs.tealdeer = {
    enable = true;

    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {
        auto_update = true;
        auto_update_interval_hours = 240;
      };
    };
  };
}