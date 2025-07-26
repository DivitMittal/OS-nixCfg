{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit (pkgs.master) gemini-cli;
  };

  programs.opencode = {
    enable = true;
    package = pkgs.master.opencode;
  };
}
