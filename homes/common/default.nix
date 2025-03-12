{ user, config, self, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  imports = [
    ./nixCfg.nix
  ];

  options = let inherit(lib) mkOption types; in {
    paths.binHome = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/.local/bin";
      description = "Path to current-user binary home";
    };

    paths.darwinCfg = mkOption {
      type = types.str;
      default = self + "/hosts/darwin";
      description = "Path to darwinCfg";
    };
  };

  config = {
    home = {
      username = user.username;
      homeDirectory = (if isDarwin then "/Users" else "/home") + "/${config.home.username}";
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
  };
}