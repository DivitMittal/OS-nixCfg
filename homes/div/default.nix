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
      # CLI tools
      bitwarden-cli rclone weechat
      # plugin/package/module managers
      pipx spicetify-cli cargo micromamba
      # developer tools
      android-tools colima docker
      # networking tools
      nmap speedtest-go bandwhich
      # file/data format
      w3m pandoc poppler chafa imagemagick ffmpeg
      # to be learned to use
      mosh
      ;

      pnpm = pkgs.nodePackages_latest.pnpm;
      fastfetch = pkgs.fastfetch.overrideAttrs { preBuild = lib.optionalString pkgs.stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0";};
  };
}