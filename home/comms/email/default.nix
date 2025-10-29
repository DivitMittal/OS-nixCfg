{
  lib,
  config,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  programs.zsh.profileExtra = "unset MAILCHECK";
  programs.bash.profileExtra = config.programs.zsh.profileExtra;
}
