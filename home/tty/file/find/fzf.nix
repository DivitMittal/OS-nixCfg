{
  pkgs,
  config,
  lib,
  ...
}: let
  eza_opts = lib.strings.concatStringsSep " " config.programs.eza.extraOptions;
  fd_opts = lib.strings.concatStringsSep " " ["--hidden"];
  delta_opts = lib.strings.concatStringsSep " " ["--paging=never"];
in {
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;

    enableFishIntegration = false;
    enableZshIntegration = false;
    enableBashIntegration = false;

    defaultCommand = "${pkgs.fd}/bin/fd ${fd_opts}";

    defaultOptions = [
      "--multi"
      "--cycle"
      "--border"
      "--height 50%"
      "--bind='right:select'"
      "--bind='left:deselect'"
      "--bind='tab:down'"
      "--bind='btab:up'"
      "--no-scrollbar"
      "--marker='*'"
      "--preview-window=wrap"
    ];
  };

  programs.fish = {
    plugins = [
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "main";
          hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
      {
        name = "fifc";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "main";
          hash = "sha256-Ynb0Yd5EMoz7tXwqF8NNKqCGbzTZn/CwLsZRQXIAVp4=";
        };
      }
    ];

    interactiveShellInit = ''
      ## PatrickF1/fzf.fish plugin
      fzf_configure_bindings --variables=\ev --processes=\ep --git_status=\es --git_log=\el --history=\er --directory=\ef
      set -gx fzf_fd_opts ${fd_opts}
      set -gx fzf_preview_dir_cmd ${pkgs.eza}/bin/eza ${eza_opts}
      set -gx fzf_preview_file_cmd ${pkgs.bat}/bin/bat
      set -gx fzf_diff_highlighter ${pkgs.delta}/bin/delta ${delta_opts}

      ## fifc plugin
      set -gx fifc_editor ${config.home.sessionVariables.VISUAL}
      set -gx fifc_fd_opts ${fd_opts}
      set -gx fifc_eza_opts ${eza_opts}
    '';
  };

  programs.zsh.antidote.plugins = ["Aloxaf/fzf-tab"];
}
