{ pkgs, lib, ... }:

{
  environment.shells = with pkgs; [ ksh tcsh ];

  environment.shellAliases = {
    cleanup-DS  = "sudo find . -type f -name '*.DS_Store' -ls -delete";
    empty-trash = "bash -c 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sudo rm -rfv /private/tmp/*.log'";
  };

  programs = let inherit(lib) mkAfter; in {
    bash.interactiveShellInit = mkAfter ''
      # Silence bash is deprecated as default shell on macOS
      export BASH_SILENCE_DEPRECATION_WARNING=1

      # Load paths from /etc/paths & /etc/paths.d/ into the path
      [ -x /usr/libexec/path_helper ] && eval `/usr/libexec/path_helper -s`

      # Source a specific bashrc for Apple Terminal (handled by nix-darwin)
      # [ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
    '';

    zsh.interactiveShellInit = mkAfter ''
      # Useful support for interacting with Terminal.app or other terminal programs
      [ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"
    '';
  };
}