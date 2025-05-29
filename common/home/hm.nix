{
  config,
  pkgs,
  lib,
  self,
  ...
}: {
  imports = [self.outputs.homeManagerModules.default];

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
  };

  programs.home-manager.enable = true; # home-manager standalone
  news.display = "show";

  xdg.enable = true;
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = true;

  home.packages = lib.attrsets.attrValues {
    my-hello = pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '';
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

  home.stateVersion = lib.mkDefault "25.05";
}