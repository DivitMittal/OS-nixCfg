_: {
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      # U-Boot on Apple Silicon does not support EFI variable writes
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };
  };

  # Asahi Linux binary cache — avoids rebuilding the custom kernel from source
  nix.settings = {
    trusted-substituters = [
      "https://nixos-apple-silicon.cachix.org"
    ];
    trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };
}
