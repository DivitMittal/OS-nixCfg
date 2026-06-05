{
  lib,
  inputs,
  hostPlatform,
  ...
}: {
  imports = [
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-installer
  ];

  image.fileName = lib.mkForce "nixos-as-${hostPlatform.system}.iso";

  # Asahi Linux binary cache — avoids rebuilding the custom kernel during ISO build
  nix.settings = {
    trusted-substituters = [
      "https://nixos-apple-silicon.cachix.org"
    ];
    trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };
}
