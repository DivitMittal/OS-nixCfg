{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      w3m
      ;
  };
}
