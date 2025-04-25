{
  lib,
  hostPlatform,
  pkgs,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  programs.zsh.profileExtra = "unset MAILCHECK";
  programs.bash.profileExtra = "unset MAILCHECK";

  home.packages = builtins.attrValues {
    thunderbird =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.thunderbird
      else pkgs.thunderbird;
  };
}
