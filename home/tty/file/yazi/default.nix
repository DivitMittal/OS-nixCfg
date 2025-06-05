{
  pkgs,
  lib,
  ...
}: {
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

  programs.yazi = let
    getPlugin = src: pluginName: {${pluginName} = src + "/${pluginName}.yazi";};
  in {
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
      flavor = {
        dark = "dracula";
      };
    };
    flavors = let
      officialFlavors = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "flavors";
        rev = "68326b4ca4b5b66da3d4a4cce3050e5e950aade5";
        hash = "sha256-nhIhCMBqr4VSzesplQRF6Ik55b3Ljae0dN+TYbzQb5s=";
      };
    in (getPlugin officialFlavors "dracula");
    plugins = let
      officialPlugins = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = "63f9650e522336e0010261dcd0ffb0bf114cf912";
        hash = "sha256-ZCLJ6BjMAj64/zM606qxnmzl2la4dvO/F5QFicBEYfU=";
      };
      # lpanebrPlugins = pkgs.fetchFromGitHub {
      #   owner = "lpanebr";
      #   repo = "yazi-plugins";
      #   rev = "ca18a2cfb893e3608997c9de54acced124373871";
      #   hash = "sha256-v+EmMbrccAlzeR9rhmlFq0f+899l624EhWx1DFz+qzc=";
      # };
      lpanebrPluginsFork = pkgs.fetchFromGitHub {
        owner = "DivitMittal";
        repo = "yazi-plugins";
        rev = "update-yatline-symlink-for-yazi's-Deprecated-API";
        hash = "sha256-wT2m05UyYqWaRSPaUe7LL9jEnPusJMpIyU9oz5J3NQU=";
      };
      getOfficialPlugin = getPlugin officialPlugins;
    in
      lib.attrsets.mergeAttrsList [
        (getOfficialPlugin "git")
        (getOfficialPlugin "smart-enter")
        (getOfficialPlugin "full-border")
        (getOfficialPlugin "diff")
        (getOfficialPlugin "chmod")
        (getOfficialPlugin "smart-filter")
        (getOfficialPlugin "mount")
        (getOfficialPlugin "toggle-pane")
        {
          ouch = pkgs.fetchFromGitHub {
            owner = "ndtoan96";
            repo = "ouch.yazi";
            rev = "10b462765f37502065555e83c68a72bb26870fe2";
            hash = "sha256-mtXl76a54Deg4cyrD0wr++sD/5b/kCsnJ+ngM6OokTc=";
          };
          richPreview = pkgs.fetchFromGitHub {
            owner = "AnirudhG07";
            repo = "rich-preview.yazi";
            rev = "fdcf37320e35f7c12e8087900eebffcdafaee8cb";
            hash = "sha256-HO9hTCfgGTDERClZaLnUEWDvsV9GMK1kwFpWNM1wq8I=";
          };
          # hexyl = pkgs.fetchFromGitHub {
          #   owner = "Reledia";
          #   repo = "hexyl.yazi";
          #   rev = "016a09bcc249dd3ce06267d54cc039e73de9c647";
          #   hash = "sha256-ly/cLKl2y3npoT2nX8ioGOFcRXI4UXbD9Es/5veUhOU=";
          # };
          hexyl = pkgs.fetchFromGitHub {
            owner = "DivitMittal";
            repo = "hexyl.yazi";
            rev = "update-deprecated-api-v25.5.31";
            hash = "sha256-n0shoqUZWUjWK+1PfPTjZxEg6g+kmWBRaFANg6sOUpI=";
          };
          yatline = pkgs.fetchFromGitHub {
            owner = "imsi32";
            repo = "yatline.yazi";
            rev = "4872af0da53023358154c8233ab698581de5b2b2";
            hash = "sha256-7uk8QXAlck0/4bynPdh/m7Os2ayW1UXbELmusPqRmf4=";
          };
          lazygit = pkgs.fetchFromGitHub {
            owner = "Lil-Dank";
            repo = "lazygit.yazi";
            rev = "7a08a0988c2b7481d3f267f3bdc58080e6047e7d";
            hash = "sha256-OJJPgpSaUHYz8a9opVLCds+VZsK1B6T+pSRJyVgYNy8=";
          };
        }
        (getPlugin lpanebrPluginsFork "yatline-symlink")
      ];
  };
}