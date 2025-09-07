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
        rev = "3e6da982edcb113d584b020d7ed08ef809c29a39";
        hash = "sha256-60XGlsdIoEJw7nf/3d6nOKsC/r83MRN5jeal2I3BYQM=";
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
            rev = "main";
            hash = "sha256-C0wG8NQ+zjAMfd+J39Uvs3K4U6e3Qpo1yLPm2xcsAaI=";
          };
        }
      ];
  };
}
