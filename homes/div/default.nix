{ config, lib, pkgs, ... }:

{
  home = {
    username      = "div";
    homeDirectory = "/Users/div";
  };

  imports = [
    ./../common
    ./programs
    ./config
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      tmux grc neovim                         # terminal Environment
      fd duf dust hexyl ouch ov               # Modern altenatives
      bitwarden-cli rclone weechat            # CLI tools
      pipx spicetify-cli cargo micromamba     # plugin/package/module managers
      mosh android-tools                      # Developer tools
      colima docker                           # Virtualization & Containerization
      nmap speedtest-go bandwhich             # networking tools
      pandoc poppler chafa imagemagick ffmpeg # file/data format
      w3m
      ;

      pnpm = pkgs.nodePackages_latest.pnpm;
  };
}