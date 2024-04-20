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
      ## Terminal Environment
      tmux grc neovim
      fd duf dust hexyl ouch ov # Modern altenatives
      bitwarden-cli rclone # CLI tools
      cargo micromamba android-tools  # Developer tools
      pipx spicetify-cli # plugin/package/module managers
      nmap speedtest-go bandwhich # networking tools
      pandoc poppler chafa imagemagick ffmpeg # file/data format
      colima docker # Virtualization & Containerization
      weechat; # IRC

    fastfetch = pkgs.fastfetch.overrideAttrs { preBuild = lib.optionalString pkgs.stdenv.isDarwin "export MACOSX_DEPLOYMENT_TARGET=14.0";};
  };
}