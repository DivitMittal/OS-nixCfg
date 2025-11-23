{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ## container runtimes
      colima
      ## container management
      docker
      lazydocker
      kubectl
      ## virtualization
      #virt-manager libvirt qemu
      ;
  };
}
