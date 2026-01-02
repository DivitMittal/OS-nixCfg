{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      geminicommit
      ;
    # aicommit2 = inputs.aicommit2.packages.${hostPlatform.system}.default;
  };
}
