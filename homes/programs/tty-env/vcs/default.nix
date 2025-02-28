{ pkgs, user, ... }:

{
  imports = [
    ./git
  ];

  programs.mercurial = {
    enable = false;
    package = pkgs.mercurial;

    userName = user.fullname;
    userEmail = builtins.elemAt user.emails 0;

    ignores = import ./common/ignore.nix;
  };
}