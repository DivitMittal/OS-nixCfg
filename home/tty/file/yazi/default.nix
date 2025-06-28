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
        rev = "d04a298a8d4ada755816cb1a8cfb74dd46ef7124";
        hash = "sha256-m3yk6OcJ9vbCwtxkMRVUDhMMTOwaBFlqWDxGqX2Kyvc=";
      };
    in
      getPlugin officialFlavors "dracula";
    plugins = let
      officialPlugins = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = "7c174cc0ae1e07876218868e5e0917308201c081";
        hash = "sha256-RE93ZNlG6CRGZz7YByXtO0mifduh6MMGls6J9IYwaFA=";
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
        (getOfficialPlugin "piper")
        (getOfficialPlugin "mime-ext")
        {
          ouch = pkgs.fetchFromGitHub {
            owner = "ndtoan96";
            repo = "ouch.yazi";
            rev = "10b462765f37502065555e83c68a72bb26870fe2";
            hash = "sha256-mtXl76a54Deg4cyrD0wr++sD/5b/kCsnJ+ngM6OokTc=";
          };
          yatline = pkgs.fetchFromGitHub {
            owner = "imsi32";
            repo = "yatline.yazi";
            rev = "4872af0da53023358154c8233ab698581de5b2b2";
            hash = "sha256-7uk8QXAlck0/4bynPdh/m7Os2ayW1UXbELmusPqRmf4=";
          };
        }
        (getPlugin lpanebrPluginsFork "yatline-symlink")
      ];
  };
}