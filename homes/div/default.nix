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
      spicetify-cli

      # developer tools
      android-tools colima docker

      jdk # Java
      pipx micromamba # Python
      cargo # Rust
      bun # Javascript

      # networking tools
      nmap speedtest-go bandwhich
      # file/data format
      w3m pandoc poppler chafa imagemagick ffmpeg

      # learning to use
      mosh
      ;

      # Javascript NodeJS
      nodejs = pkgs.nodejs_22;
      pnpm = pkgs.nodePackages_latest.pnpm;

      fastfetch = pkgs.fastfetch.overrideAttrs { preBuild = lib.optionalString pkgs.stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0";};
  };
}