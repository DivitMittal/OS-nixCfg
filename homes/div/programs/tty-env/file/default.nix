{ pkgs, ... }:

{
  imports = [
    ./find
    ./yazi
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      pandoc tectonic-unwrapped poppler rich-cli # documents
      ouch                                       # archives
      hexyl                                      # binary & misc.
    ;
  };
}