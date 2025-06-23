{pkgs, ...}: {
  # home.packages = lib.lists.optionals config.xdg.configFile."hammerspoon".enable [pkgs.brewCasks.hammerspoon];

  # run once: defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
  # xdg.configFile."hammerspoon" = {
  #   enable = true;
  #   source = ./config;
  #   recursive = true;
  # };
  # xdg.configFile."hammerspoon/Spoons/VimMode.spoon" = {
  #   enable = true;
  #   source = vimModeSpoon;
  #   recursive = true;
  # };
  programs.hammerspoon = {
    enable = true;
    package = pkgs.brewCasks.hammerspoon;

    configPath = ./config;
    spoons = {
      VimMode = pkgs.fetchFromGitHub {
        repo = "VimMode.spoon";
        owner = "dbalatero";
        rev = "dda997f79e240a2aebf1929ef7213a1e9db08e97";
        hash = "sha256-zpx2lh/QsmjP97CBsunYwJslFJOb0cr4ng8YemN5F0Y=";
      };
    };
  };
}