{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home = {
    inherit (config.hostSpec) username;
    homeDirectory = config.hostSpec.home;
  };

  programs.home-manager.enable = true;
  news.display = "show";

  xdg.enable = true;
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = true;

  home.packages = builtins.attrValues {
    my-hello = pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.home.username}!"'';
  };
  home.extraOutputsToInstall = ["info"]; # "doc" "devdoc"

  home.language = {
    base = "en_US.UTF-8";
  };

  manual = {
    html.enable = true;
    json.enable = false;
    manpages.enable = false;
  };

  home.stateVersion = "25.05";
}
