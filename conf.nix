{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkDefault;
in {
  nix = {
    enable = true;
    package = mkDefault pkgs.lix; # test lix, alt to CppNix
    checkConfig = mkDefault true;

    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];

      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB
      warn-dirty = mkDefault true;

      use-xdg-base-directories = mkDefault true;
      substituters = [
        "https://divitmittal.cachix.org"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
        "https://cache.lix.systems"
      ];
      trusted-public-keys = [
        "divitmittal.cachix.org-1:Fx7nQrvET1RKTTrxQHMDP/Relbu072af/MFG4BYvpjw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      ];

      trusted-users = ["${config.hostSpec.username}"];
    };
  };
}
