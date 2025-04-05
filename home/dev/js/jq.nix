{pkgs, ...}: {
  ## JSON
  programs.jq = {
    enable = true;
    package = pkgs.jq;

    colors = {
      arrays = "1;37";
      false = "0;37";
      null = "1;30";
      numbers = "0;37";
      objectKeys = "1;34";
      objects = "1;37";
      strings = "0;32";
      true = "0;37";
    };
  };
}
