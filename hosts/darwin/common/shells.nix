{ lib, pkgs, ... }:

{
  environment.shellAliases = {
    dt          = "builtin cd $HOME/Desktop/";
    dl          = "builtin cd $HOME/Downloads/";
    cleanup-DS  = "sudo find . -type f -name '*.DS_Store' -ls -delete";
    empty-trash = "bash -c 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sudo rm -rfv /private/tmp/*.log'";
  };

  programs = {
    bash.interactiveShellInit = lib.mkAfter ''
      export BASH_SILENCE_DEPRECATION_WARNING=1

      [ -x /usr/libexec/path_helper ] && eval `/usr/libexec/path_helper -s` # load paths from /etc/paths & /etc/paths.d/ into the path
      # [ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM" # source a specific bashrc for Apple Terminal (handled by nix-darwin)
    '';

    zsh.interactiveShellInit = lib.mkAfter ''
      [ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM" # Useful support for interacting with Terminal.app or other terminal programs
    '';
  };
}