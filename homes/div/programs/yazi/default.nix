{ pkgs, config, ... }:

{
  programs.fish.functions = {
    yy = {
      body = ''
        set tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (env cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
  };

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;

    enableFishIntegration = false; enableZshIntegration = false; enableBashIntegration = false;

    settings = import ./yazi.nix;
    keymap = import ./keymap.nix;
    theme = import ./theme.nix;
    initLua = ./init.lua;
    plugins = {
      smart-enter = ./plugins/smart-enter.yazi;
    };
  };
}