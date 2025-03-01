_:

{
  imports = [
    ./aerc
    ./oauth
  ];

  programs.zsh.profileExtra = "unset MAILCHECK";
  programs.bash.profileExtra = "unset MAILCHECK";
}