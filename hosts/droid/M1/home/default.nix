{ pkgs, repo, config, ... }:

let
  programs = /${repo}/homes/programs;
in
{
  imports = [
    /${programs}/tty-env
  ];

  programs.home-manager.enable = true;
  news.display = "show";
  xdg.enable = true;
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = true;

  home.packages = builtins.attrValues {
    my-hello = pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.user.name}!"'';
  };
  home.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

  home.stateVersion = "25.05";
}