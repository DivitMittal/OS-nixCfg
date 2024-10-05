{ config, lib, pkgs, ... }:

let
  inherit(lib) mkOption types;
in
{
  imports = [
    ./nixCfg.nix
  ];

  options = {
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

    paths.homeCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/homes/${config.home.username}";
      description = "Path to current-user home-manager module";
    };

    paths.darwinCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/hosts/darwin";
      description = "Path to darwinCfg";
    };
  };

  config = {
    programs.home-manager.enable = true;

    xdg.enable = true;
    home.preferXdgDirectories = true;

    home.packages = builtins.attrValues {
      my-hello = pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.home.username}!"'';
    };

    home.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

    home.stateVersion = "24.05";
  };
}