{ config, lib, pkgs, ... }:

{
  imports = [
    ./nixCfg.nix
  ];

  options = {
    paths.homeCfg = "${config.home.homeDirectory}/OS-nixCfg/homes/${config.home.username}";
  };

  config = {
    xdg.enable = true;
    home.preferXdgDirectories  = lib.mkDefault true;

    home.packages = builtins.attrValues {
      my-hello  = pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.home.username}!"'';
    };
    home.extraOutputsToInstall = [ "doc" "info" "devdoc" ];

    programs.home-manager.enable = true;

    home.stateVersion = lib.mkDefault "23.11";
  };
}