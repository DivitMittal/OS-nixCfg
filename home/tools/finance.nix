{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      tickrs
      cointop
      ;

    hisaab = pkgs.writeShellScriptBin "hisaab" ''
      if [ $# -eq 1 ]; then
        echo "$@" | sed -E 's/\([A-Za-z&]*\)//g' | ${pkgs.bc}/bin/bc -q
      else
        echo "Please provide a valid input" >&2
        exit 1
      fi
    '';
  };
}
