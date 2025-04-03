{
  lib,
  pkgs,
  ...
}: {
  imports = lib.custom.scanPaths ./.;

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ## containerization
      #docker lazydocker
      ## virtualization
      #virt-manager libvirt qemu
      ;
  };
}
