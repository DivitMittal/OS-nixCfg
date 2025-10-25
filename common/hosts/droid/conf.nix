_: {
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
  nix.settings = {
    extra-platforms = ["aarch64-linux" "arm-linux"];
    substituters = [
      "https://nix-on-droid.cachix.org"
    ];
    trused-public-keys = [
      "nix-on-droid.cachix.org-1:56snoMJTXmE7wm+67YySRoTY64Zkivk9RT4QaKYgpkE="
    ];
  };
}
