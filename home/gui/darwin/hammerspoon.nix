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
  };
}
