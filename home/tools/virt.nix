{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      ## containerization
      #docker lazydocker

      ## virtualization
      #virt-manager libvirt qemu
    ;

    # colima = (if hostPlatform.isDarwin then pkgs.colima else null);
  };
}