{ user, config, pkgs, hostPlatform,... }:

{
  home = {
    username = user.username;
    homeDirectory = (if hostPlatform.isDarwin then "/Users" else "/home") + "/${config.home.username}";
  };

  programs.home-manager.enable = true;
  news.display = "show";

  xdg.enable = true;
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = true;

  home.packages = builtins.attrValues {
    my-hello = pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.home.username}!"'';
  };
  home.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

  home.stateVersion = "25.05";
}