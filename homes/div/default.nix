{ config, username, pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  imports = [
    ./../common
    ./config
    ./programs
  ];

  home = {
    inherit username;
    homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
  };
}