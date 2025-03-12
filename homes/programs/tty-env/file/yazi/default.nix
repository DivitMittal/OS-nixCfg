{ pkgs, ... }:

{
  programs.fish.functions = {
    y = {
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

    enableFishIntegration = false;
    enableZshIntegration = false;
    enableBashIntegration = false;
    enableNushellIntegration = false;

    initLua = ./init.lua;
    settings = import ./yazi.nix;
    keymap = import ./keymap.nix;
    theme = {
      flavor.dark = "dracula";
    };
    flavors =
      let
        officialFlavors = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "main";
          hash = "sha256-iTMch0T933Tvofvo3ZzFwk+PNs+dsK0SrAIlJ03v73E=";
        };
      in
      {
        dracula = builtins.toPath "${officialFlavors}/dracula.yazi";
      };
    plugins =
      let
        officialPlugins = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "plugins";
          rev = "main";
          hash = "sha256-mqo71VLZsHmgTybxgqKNo9F2QeMuCSvZ89uen1VbWb4=";
        };
      in
      {
        git = builtins.toPath "${officialPlugins}/git.yazi";
        smart-enter = builtins.toPath "${officialPlugins}/smart-enter.yazi";
        full-border = builtins.toPath "${officialPlugins}/full-border.yazi";
        diff = builtins.toPath "${officialPlugins}/diff.yazi";
        chmod = builtins.toPath "${officialPlugins}/chmod.yazi";
        smart-filter = builtins.toPath "${officialPlugins}/smart-filter.yazi";
        mount = builtins.toPath "${officialPlugins}/mount.yazi";
        toggle-pane = builtins.toPath "${officialPlugins}/toggle-pane.yazi";
        ouch = pkgs.fetchFromGitHub {
          owner = "ndtoan96";
          repo = "ouch.yazi";
          rev = "main";
          hash = "sha256-oUEUGgeVbljQICB43v9DeEM3XWMAKt3Ll11IcLCS/PA=";
        };
        richPreview = pkgs.fetchFromGitHub {
          owner = "AnirudhG07";
          repo = "rich-preview.yazi";
          rev = "main";
          sha256 = "sha256-dW2gAAv173MTcQdqMV32urzfrsEX6STR+oCJoRVGGpA=";
        };
        hexyl = pkgs.fetchFromGitHub {
          owner = "Reledia";
          repo = "hexyl.yazi";
          rev = "main";
          sha256 = "sha256-Xv1rfrwMNNDTgAuFLzpVrxytA2yX/CCexFt5QngaYDg=";
        };
      };
  };
}