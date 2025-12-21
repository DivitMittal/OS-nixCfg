{
  lib,
  hostPlatform,
  ...
}: {
  image.fileName = lib.mkForce "nixos-custom-${hostPlatform.system}.iso";
}
