{ config, lib, pkgs, ... }:

{
  home = {
    username      = "div";
    homeDirectory = "/Users/${config.home.username}";
  };

  imports = [
    ./../common
    ./programs
    ./config
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      duf dust hexyl ouch ov   # Modern altenatives

      # CLI tools
      grc bitwarden-cli rclone weechat

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
      w3m pandoc poppler chafa imagemagick ffmpeg rich-cli

      # learning to use
      mosh
      ;

      # Javascript NodeJS
      nodejs = pkgs.nodejs_22;
      pnpm = pkgs.nodePackages_latest.pnpm;

      fastfetch = pkgs.fastfetch.overrideAttrs { preBuild = lib.optionalString pkgs.stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0";};
  };
}