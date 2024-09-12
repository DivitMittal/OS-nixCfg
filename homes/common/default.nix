{ config, lib, pkgs, ... }:

{
  imports = [
    ./nixCfg.nix
  ];

  options = {
    paths.homeCfg = lib.mkOption {
      type = lib.types.str;
      description = "Path to current-user home-manager module";
    };

    paths.secrets = lib.mkOption {
      type = lib.types.str;
      description = "Path to secrets";
    };
  };

  config = {
    programs.home-manager.enable = true;

    xdg.enable = true;
    home.preferXdgDirectories = true;

    paths.homeCfg = "${config.home.homeDirectory}/OS-nixCfg/homes/${config.home.username}";
    paths.secrets = "${config.home.homeDirectory}/OS-nixCfg/secrets";

    home.packages = builtins.attrValues {
      my-hello = pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.home.username}!"'';
    };

    home.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

    home.stateVersion = "23.11";
  };
}