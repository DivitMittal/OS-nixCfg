{ pkgs, ... }:

{
  imports = [
    ./network
    ./wezterm
    ./privacy.nix
    ./rclone.nix
  ];

  home.packages = builtins.attrValues {
    inherit(pkgs)
      # AI
      aichat

      ttyper
    ;
  };
}