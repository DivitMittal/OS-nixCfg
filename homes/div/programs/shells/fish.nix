{ config, pkgs, lib, ... }:

let
  eza_opts = lib.strings.concatStringsSep " " config.programs.eza.extraOptions;
  fd_opts = "--hidden";
in
{
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    functions = {
      cht = { body = ''curl -ssL "https://cheat.sh/$argv''; };
    };

    shellAliases = {
      gem-ultimate  = "sudo -v; gem cleanup; and gem update; and gem cleanup";
      brew-ultimate = "brew update; and brew upgrade; and brew autoremove; and brew cleanup -s --prune=0; and rm -rf (brew --cache)";
      apps-backup   = "env ls /Applications/ 1> ${config.home.homeDirectory}/OS-nixCfg/homes/${config.home.username}/etc/apps/apps_(date +%b%y).txt";
    };

    shellAbbrs = {
      ".2"  = { expansion = "cd ../.."   ; position = "anywhere";};
      ".3"  = { expansion = "cd ../../.."; position = "anywhere";};
    };

    interactiveShellInit = ''
      # PatrickF1/fzf.fish plugin
      set -gx fzf_fd_opts ${fd_opts}
      set -gx fzf_preview_dir_cmd eza ${eza_opts}
      set -gx fzf_diff_highlighter delta --paging=never --width=20
      set -gx fzf_preview_file_cmd bat --style=numbers
      fzf_configure_bindings --variables=\ev --processes=\ep --git_status=\es --git_log=\el --history=\er --directory=\ef

      # fifc plugin
      set -gx fifc_editor ${config.home.sessionVariables.VISUAL}
      set -gx fifc_fd_opts ${fd_opts}
      set -gx fifc_eza_opts ${eza_opts}
    '';

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
    text = ''
      jorgebucaran/autopair.fish
      nickeb96/puffer-fish
      markcial/upto
      patrickf1/fzf.fish
      lengyijun/fc-fish
      edc/bass
      oh-my-fish/plugin-wttr
      oh-my-fish/plugin-osx
      divitmittal/fifc@bugfix
    '';
    target = "${config.xdg.configHome}/fish/fish_plugins";
  };
}