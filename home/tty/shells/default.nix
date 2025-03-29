{ pkgs, hostPlatform, lib, ... }:

{
  imports = lib.custom.scanPaths ./.;

  home.packages = builtins.attrValues {
    powershell = pkgs.powershell;
    terminal-notifier = if hostPlatform.isDarwin then pkgs.terminal-notifier else null;
  };

  programs.nushell = {
    enable = true;
    package = pkgs.nushell;

    configFile.text = ''
      $env.config = {
        show_banner: false,
      }
    '';
  };

  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    enableBashIntegration = true;
    # enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
}