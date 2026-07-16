{
  lib,
  config,
  hostPlatform,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  programs.nix-ld.enable = true;

  system.stateVersion = mkDefault "26.11";

  # Enable building aarch64 packages for nix-on-droid deployment
  # Uses QEMU user-mode emulation via binfmt_misc
  boot.binfmt.emulatedSystems = mkDefault (lib.lists.optionals (hostPlatform.system != "aarch64-linux") ["aarch64-linux"]);

  nix.optimise.dates = mkDefault ["Sun 22:00"];

  users.users = {
    "${config.hostSpec.username}" = {
      isNormalUser = true;
    };
  };

  environment.systemPackages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      clang
      ;
  };
}
