{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    powershell = pkgs.powershell;
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
}