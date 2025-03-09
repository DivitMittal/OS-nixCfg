{ config, pkgs, ... }:

let
  fishPlugins = [
    "jorgebucaran/autopair.fish"
    "nickeb96/puffer-fish"
    "markcial/upto"
    "lengyijun/fc-fish"
    "edc/bass"
    "oh-my-fish/plugin-osx"
  ];
in
{
  home.file.fisherPlugins = {
    enable = true;
    text = builtins.concatStringsSep "\n" fishPlugins;
    target = "${config.xdg.configHome}/fish/fish_plugins";
  };

  programs.fish = {
    enable = true;
    package = pkgs.fish;

    loginShellInit = ''
      set -g fish_greeting
    '';

    interactiveShellInit = ''
      set -g fish_vi_force_cursor 1
      set -g fish_cursor_default block
      set -g fish_cursor_visual block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace_one underscore
    '';

    functions = {
      cht = "curl -ssL https://cheat.sh/$argv";

      gitignore = "curl -sL https://www.gitignore.io/api/$argv";

      hisaab = ''
        if test (count $argv) -eq 1
          echo $argv | sed -E 's/\(([A-Za-z&])*\)//g' | bc -q
        else
          echo "Please provide a valid input"
        end
      '';
    };

    shellAliases = {
      brew-ultimate = "brew update; and brew upgrade; and brew autoremove; and brew cleanup -s --prune=0; and rm -rf (brew --cache)";
      apps-backup   = "env ls /Applications/ 1> ${config.paths.darwinCfg}/L1/apps/bak/apps_(date +%b%y).txt";
    };

    shellAbbrs = {
      ".2" = { expansion = "../.."   ; position = "anywhere";};
      ".3" = { expansion = "../../.."; position = "anywhere";};
    };

    plugins = [
      {
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "fisher";
          rev = "4.4.5";
          hash = "sha256-VC8LMjwIvF6oG8ZVtFQvo2mGdyAzQyluAGBoK8N2/QM=";
        };
      }
    ];
  };
}