{
  pkgs,
  hostPlatform,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # Office files (e.g., .docx, .xlsx, .pptx)
    onlyoffice =
      if hostPlatform.isDarwin
      then (pkgs.brewCasks.onlyoffice.override {variation = "sequoia";})
      else pkgs.onlyoffice;
  };

  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
  };
}