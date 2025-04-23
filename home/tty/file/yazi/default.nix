{pkgs, ...}: {
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
    flavors = let
      officialFlavors = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "flavors";
        rev = "main";
        hash = "sha256-nhIhCMBqr4VSzesplQRF6Ik55b3Ljae0dN+TYbzQb5s=";
      };
    in {
      dracula = builtins.toPath "${officialFlavors}/dracula.yazi";
    };
    plugins = let
      officialPlugins = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = "main";
        hash = "sha256-auGNSn6tX72go7kYaH16hxRng+iZWw99dKTTUN91Cow=";
      };
    in {
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
        hash = "sha256-OsNfR7rtnq+ceBTiFjbz+NFMSV/6cQ1THxEFzI4oPJk=";
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
        sha256 = "sha256-ly/cLKl2y3npoT2nX8ioGOFcRXI4UXbD9Es/5veUhOU=";
      };
    };
  };
}