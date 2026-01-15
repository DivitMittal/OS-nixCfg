{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = lib.custom.scanPaths ./.;

  home.packages = mkIf config.programs.codex.enable (lib.attrsets.attrValues {
    inherit (pkgs.ai) ccusage-codex;
  });

  programs.codex = let
    package = pkgs.ai.codex;
  in {
    enable = true;
    inherit package;
  };
}
