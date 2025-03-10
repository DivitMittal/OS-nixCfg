{ pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  home.packages = builtins.attrValues {
    inherit(pkgs)
      # containerization
      docker lazydocker

      # virtualization
      #virt-manager libvirt qemu
    ;

    colima = if isDarwin then pkgs.colima else null;
  };
}