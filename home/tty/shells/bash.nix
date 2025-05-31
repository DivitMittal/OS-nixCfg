{config, ...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;

    sessionVariables.BADOTDIR = "${config.xdg.configHome}/bash";
    historyControl = ["ignoreboth"];
    historyFile = "${config.programs.bash.sessionVariables.BADOTDIR}/.bash_history";
    historyIgnore = [
      "ls"
      "cd"
      "pwd"
      "exit"
      "clear"
      "history"
    ];

    # All interactive sessions
    initExtra = ''set -o vi # vi keybindings'';
  };
}
