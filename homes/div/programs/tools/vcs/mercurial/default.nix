{ pkgs, ... }:

{
  programs.mercurial = {
    enable = true;
    package = pkgs.mercurial;

    userName = "Divit Mittal";
    userEmail = "64.69.76.69.74.m@gmail.com";

    ignores = import ./../common/ignore.nix;
  };
}