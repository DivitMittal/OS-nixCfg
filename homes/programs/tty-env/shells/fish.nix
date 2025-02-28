{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    package = pkgs.fish;

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
      ".2"  = { expansion = "../.."   ; position = "anywhere";};
      ".3"  = { expansion = "../../.."; position = "anywhere";};
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

  home.file.fisherPlugins = {
    enable = true;

    text = ''
      jorgebucaran/autopair.fish
      nickeb96/puffer-fish
      markcial/upto
      lengyijun/fc-fish
      edc/bass
      oh-my-fish/plugin-osx
    '';
    target = "${config.xdg.configHome}/fish/fish_plugins";
  };
}