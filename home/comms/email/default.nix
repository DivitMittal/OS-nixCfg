{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = lib.custom.scanPaths ./.;

  programs.zsh = mkIf config.programs.zsh.enable {
    profileExtra = "unset MAILCHECK";
  };
  programs.bash = mkIf config.programs.bash.enable {
    inherit (config.programs.zsh) profileExtra;
  };
}
