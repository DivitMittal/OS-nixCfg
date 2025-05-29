{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkAfter;
in {
  # environment.shells = lib.attrsets.attrVals [ "ksh" "tcsh" ] pkgs;

  environment.systemPackages = lib.attrsets.attrValues {
    empty-trash = pkgs.writeShellScriptBin "empty-trash" ''
      rm -rfv /Volumes/*/.Trashes
      rm -rfv ~/.Trash
      rm -rfv /private/var/log/asl/*.asl
      rm -rfv /private/tmp/*.log
    '';

    cleanup-DS = pkgs.writeShellScriptBin "cleanup-DS" ''
      ${pkgs.findutils}/bin/find . -type f -name '*.DS_Store' -ls -delete
    '';
  };

  programs.bash.interactiveShellInit = mkAfter ''
    # Silence bash is deprecated as default shell on macOS
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Load paths from /etc/paths & /etc/paths.d/ into the path
    [ -x /usr/libexec/path_helper ] && eval `/usr/libexec/path_helper -s`

    # Source a specific bashrc for Apple Terminal (handled by nix-darwin)
    # [ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
  '';

  programs.zsh.interactiveShellInit = mkAfter ''
    # Useful support for interacting with Terminal.app or other terminal programs
    [ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"
  '';
}
