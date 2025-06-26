{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    # inherit (pkgs) gemini-cli;
  };
}
