{ pkgs, lib, config, ... }:

let
  inherit(lib) mkDefault;
  p = "${config.paths.homes}/div/programs";
in
{
  imports = [
    ./${p}/editors/editorconfig.nix
    ./${p}/editors/nvim
    ./${p}/editors/vim
    ./${p}/terminal
  ];

  nixpkgs.config = {
    allowBroken = mkDefault false;
    allowUnsupportedSystem = mkDefault false;
    allowUnfree = mkDefault true;
    allowInsecure = mkDefault true;
  };

  programs.home-manager.enable = true;
  xdg.enable = true;
  home.enableNixpkgsReleaseCheck = true;

  home.packages = builtins.attrValues {
    inherit(pkgs)
    ;
  };
  home.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

  home.stateVersion = "24.05";
}