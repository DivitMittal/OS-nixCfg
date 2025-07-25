{
  pkgs,
  lib,
  inputs,
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
        rev = "d3fd3a5d774b48b3f88845f4f0ae1b82f106d331";
        hash = "sha256-RtunaCs1RUfzjefFLFu5qLRASbyk5RUILWTdavThRkc=";
      };
    in
      getPlugin officialFlavors "dracula";
    plugins = let
      getOfficialPlugin = getPlugin inputs.yazi-plugins;
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
        {
          ouch = pkgs.fetchFromGitHub {
            owner = "ndtoan96";
            repo = "ouch.yazi";
            rev = "0742fffea5229271164016bf96fb599d861972db";
            hash = "sha256-C0wG8NQ+zjAMfd+J39Uvs3K4U6e3Qpo1yLPm2xcsAaI=";
          };
        }
      ];
  };
}
