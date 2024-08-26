{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    functions = {
      cht = { body = ''curl -ssL "https://cheat.sh/$argv''; };

      hisaab = {
        body = ''
          function hisaab -d "calculates hisaab sum"
            if test (count $argv) -eq 1
              echo $argv | sed -E 's/\(([A-Za-z&])*\)//g' | bc -q
            else
              echo "please provide me with a valid input"
            end
          end
        '';
      };
    };

    shellAliases = {
      gem-ultimate  = "sudo -v; gem cleanup; and gem update; and gem cleanup";
      brew-ultimate = "brew update; and brew upgrade; and brew autoremove; and brew cleanup -s --prune=0; and rm -rf (brew --cache)";
      apps-backup   = "env ls /Applications/ 1> ${config.home.homeDirectory}/OS-nixCfg/homes/${config.home.username}/etc/apps/apps_(date +%b%y).txt";
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
          rev = "4.4.4";
          hash = "sha256-e8gIaVbuUzTwKtuMPNXBT5STeddYqQegduWBtURLT3M=";
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
      oh-my-fish/plugin-osx'';
    target = "${config.xdg.configHome}/fish/fish_plugins";
  };
}