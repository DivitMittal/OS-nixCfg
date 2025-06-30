{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) hammerspoon-nix;
in {
  imports = [hammerspoon-nix.homeManagerModules.default];

  programs.hammerspoon = {
    enable = true;
    package = pkgs.brewCasks.hammerspoon;

    configPath = hammerspoon-nix + "/myCfg";
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
