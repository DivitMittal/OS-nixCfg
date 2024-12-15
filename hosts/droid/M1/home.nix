{ pkgs, lib, repo, config, ... }:

let
  divPrograms = /${repo}/homes/div/programs;
in
{
  imports = [
    /${divPrograms}/editors
    /${divPrograms}/terminal
  ];

  nixpkgs.config = let inherit(lib) mkDefault; in {
    allowBroken = mkDefault false;
    allowUnsupportedSystem = mkDefault false;
    allowUnfree = mkDefault true;
    allowInsecure = mkDefault true;
  };

  programs.home-manager.enable = true;
  xdg.enable = true;
  home.enableNixpkgsReleaseCheck = true;

  home.packages = builtins.attrValues {
    my-hello = pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.user.name}!"'';
  };
  home.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

  home.stateVersion = "24.05";
}
