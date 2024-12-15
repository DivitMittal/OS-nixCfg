{ pkgs, ... }:

{    
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = true;

  xdg.enable = true;

  home.packages = builtins.attrValues {
    inherit(pkgs)
      neovim-unwrapped
      gh
    ;
  };
  home.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

  home.stateVersion = "24.05";
}
