{ config, pkgs, ... }:

{
  imports = [
    ./../common
    ./config
    ./programs
  ];

  home = rec {
    username = "div";
    homeDirectory = if pkgs.stdenvNoCC.hostPlatform.isDarwin then "/Users/${username}" else "/home/${username}";
  };
}