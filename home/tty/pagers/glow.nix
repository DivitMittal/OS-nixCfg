{pkgs, ...}: {
  programs.glow = {
    enable = true;
    package = pkgs.glow;
    settings = {
      style = "auto";
      mouse = true;
      pager = true;
      width = 80;
      all = true;
    };
  };
}