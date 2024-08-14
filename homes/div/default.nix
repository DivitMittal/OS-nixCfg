{ config, pkgs, ... }:

{
  home = {
    username      = "div";
    homeDirectory = "/Users/${config.home.username}";
  };

  imports = [
    ./../common
    ./config
    ./programs
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      # Modern altenatives
      duf dust hexyl ouch

      # CLI tools
      grc bitwarden-cli rclone

      # developer tools
      android-tools colima docker

      # networking tools
      nmap speedtest-go bandwhich
      # file/data format
      w3m pandoc poppler chafa imagemagick ffmpeg rich-cli

      # learning to use
      mosh
      ;
  };
}