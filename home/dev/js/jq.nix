{ pkgs, ... }:

{
  ## JSON
  programs.jq = {
    enable = true;
    package = pkgs.jq;

    colors = {
      null = "1;30";
      false = "0;31";
      true = "0;32";
      numbers = "0;36";
      strings = "0;33";
      arrays = "1;35";
      objects = "1;37";
    };
  };
}