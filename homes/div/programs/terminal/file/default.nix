{ pkgs, ... }:

{
  imports = [
    ./find
    ./yazi
    ./rclone.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      pandoc tectonic-unwrapped poppler rich-cli # documents
      ouch                                       # archives
      hexyl                                      # binary & misc.
    ;
  };
}