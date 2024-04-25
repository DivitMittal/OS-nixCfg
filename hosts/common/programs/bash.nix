_:
{
  programs.bash = {
    enable = true;

    interactiveShellInit = ''
      # [ -z "$PS1" ] && return                                             # exit if running non-interactively (handled by nix-darwin)

      [ -x /usr/libexec/path_helper ] && eval `/usr/libexec/path_helper -s` # load paths from /etc/paths & /etc/paths.d/ into the path

      if [ "`id -u`" -eq 0 ]; then
        PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
      else
        PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
      fi
      set -o vi                                                             # vi keybindings

      export BASH_SILENCE_DEPRECATION_WARNING=1

      # shopt -s checkwinsize                                               # check window size after every command       (handled by nix-darwin)
      # [ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM" # source a specific bashrc for Apple Terminal (handled by nix-darwin)
    '';
  };
}