{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    vscode =
      if hostPlatform.isDarwin
      then
        (
          if hostPlatform.isx86_64
          then (pkgs.brewCasks.visual-studio-code.override {variation = "sequoia";})
          else pkgs.brewCasks.visual-studio-code
        )
      else pkgs.vscode;
  };
}
