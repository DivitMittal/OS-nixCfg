{pkgs, ...}: {
  home.packages = with pkgs; [ lynx ];

  home.file.".lynxrc".source = ./lynxrc;
}