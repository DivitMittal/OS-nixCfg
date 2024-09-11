{ config, pkgs, ... }:

{
  imports = [
    ./../common
    ./config
    ./programs
  ];

  home = rec {
    username = "div";
    homeDirectory = "/Users/${username}";
  };
}