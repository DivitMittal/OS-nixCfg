{
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      geminicommit
      ;
    aicommit2 = inputs.aicommit2.packages.${pkgs.system}.default;
  };
}
