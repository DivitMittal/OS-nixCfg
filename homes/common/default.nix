{ user, config, lib, pkgs, ... }:

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

    paths.repo = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/OS-nixCfg";
      description = "Path to the main repo containing home-manager & other nix configs";
    };

    paths.secrets = mkOption {
      type = types.str;
      default = "${config.paths.repo}/secrets";
      description = "Path to secrets";
    };

    paths.programs = mkOption {
      type = types.str;
      default = "${config.paths.repo}/homes/programs";
      description = "Path to current-user home-manager module";
    };

    paths.darwinCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/hosts/darwin";
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