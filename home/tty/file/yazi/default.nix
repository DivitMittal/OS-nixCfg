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
    settings = builtins.import ./yazi.nix;
    keymap = builtins.import ./keymap.nix;
    theme = {
      flavor.dark = "dracula";
    };
    flavors = let
      officialFlavors = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "flavors";
        rev = "68326b4ca4b5b66da3d4a4cce3050e5e950aade5";
        hash = "sha256-nhIhCMBqr4VSzesplQRF6Ik55b3Ljae0dN+TYbzQb5s=";
      };
    in {
      dracula = builtins.toPath "${officialFlavors}/dracula.yazi";
    };
    plugins = let
      officialPlugins = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = "4b027c79371af963d4ae3a8b69e42177aa3fa6ee";
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
        rev = "2496cd9ac2d1fb52597b22ae84f3af06c826a86d";
        hash = "sha256-OsNfR7rtnq+ceBTiFjbz+NFMSV/6cQ1THxEFzI4oPJk=";
      };
      richPreview = pkgs.fetchFromGitHub {
        owner = "AnirudhG07";
        repo = "rich-preview.yazi";
        rev = "fdcf37320e35f7c12e8087900eebffcdafaee8cb";
        hash = "sha256-HO9hTCfgGTDERClZaLnUEWDvsV9GMK1kwFpWNM1wq8I=";
      };
      hexyl = pkgs.fetchFromGitHub {
        owner = "Reledia";
        repo = "hexyl.yazi";
        rev = "016a09bcc249dd3ce06267d54cc039e73de9c647";
        hash = "sha256-ly/cLKl2y3npoT2nX8ioGOFcRXI4UXbD9Es/5veUhOU=";
      };
    };
  };
}