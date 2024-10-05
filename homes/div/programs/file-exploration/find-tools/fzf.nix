{ pkgs, lib, config, ... }:

let
  inherit(lib) mkAfter;
  eza_opts = builtins.concatStringsSep " " config.programs.eza.extraOptions;
  fd_opts = "--hidden";
  delta_opts = "--paging=never";
  fishFzfPlugins = [
    "patrickf1/fzf.fish"
    "gazorby/fifc"
    #divitmittal/fifc@bugfix
  ];
in
{
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;

    enableFishIntegration = false; enableZshIntegration = false; enableBashIntegration = false;

    defaultCommand = "fd ${fd_opts}";

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

  programs.fish.interactiveShellInit = ''
    # PatrickF1/fzf.fish plugin
    fzf_configure_bindings --variables=\ev --processes=\ep --git_status=\es --git_log=\el --history=\er --directory=\ef
    set -gx fzf_fd_opts ${fd_opts}
    set -gx fzf_preview_dir_cmd eza ${eza_opts}
    set -gx fzf_preview_file_cmd bat
    set -gx fzf_diff_highlighter delta ${delta_opts}

    # fifc plugin
    set -gx fifc_editor ${config.home.sessionVariables.VISUAL}
    set -gx fifc_fd_opts ${fd_opts}
    set -gx fifc_eza_opts ${eza_opts}
  '';

  home.file.fisherPlugins.text = mkAfter (builtins.concatStringsSep "\n" fishFzfPlugins);
  programs.zsh.antidote.plugins = [ "Aloxaf/fzf-tab" ];
}