{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      alt-tab-macos
      ;
  };
}
