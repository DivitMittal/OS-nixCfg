{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      ouch                                       # archives
      hexyl                                      # binary & misc.
      pandoc tectonic-unwrapped poppler rich-cli # documents
    ;
  };
}