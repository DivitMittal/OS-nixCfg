{ config, pkgs, ... }:

{
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR   = "nvim"; VISUAL = "nvim";
    PAGER    = "less"; LESS   = "--RAW-CONTROL-CHARS --mouse -C --tilde --tabs=2 -W --status-column -i"; LESSHISTFILE = "-";
    LESSOPEN = "|${pkgs.lesspipe}/bin/lesspipe.sh %s"; LESSCOLORIZER = "bat";
    SCREENRC = "${config.xdg.configHome}/screen/screenrc";
  };

  home.shellAliases  = {
    man               = "batman";
    cat               = "bat --paging=never";
    cleanup-DS        = "sudo find . -type f -name '*.DS_Store' -ls -delete";
    empty-trash       = "bash -c 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sudo rm -rfv /private/tmp/*.log'";
    pip-uninstall-all = "pip freeze | cut -d '@' -f1 | xargs pip uninstall -y";
    lt                = "eza --tree --level=2";
    ll                = "eza -albhHigUuS -m@ | ov -H1";
  };

  imports = [
    ./fish.nix
    ./zsh.nix
    ./bash.nix
  ];
}