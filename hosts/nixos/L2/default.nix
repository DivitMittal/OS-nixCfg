{inputs, ...}: {
  imports = [(inputs.import-tree.matchNot ".*/default\\.nix" ./.)];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
}
