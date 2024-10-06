{ config, username, pkgs, ... }:

{
  imports = [
    ./../common
    ./config
    ./programs
  ];

  home = {
    username = "${username}";
    homeDirectory = if pkgs.stdenvNoCC.hostPlatform.isDarwin then "/Users/${username}" else "/home/${username}";
  };
}