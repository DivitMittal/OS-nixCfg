{
  pkgs,
  lib,
  ...
}: {
  # Enable colima as a service with docker runtime
  services.colima = {
    enable = true;
    coreutilsPackage = pkgs.uutils-coreutils;
    profiles.default = {
      isActive = true;
      isService = false;
      settings = {
        # Container runtime
        runtime = "docker";

        cpu = 6;
        memory = 6;
        disk = 10;

        # Disable kubernetes
        kubernetes.enabled = false;

        # VM settings
        vmType = "vz"; # Apple Virtualization.framework (faster on Apple Silicon)
        autoActivate = true;
      };
    };
  };

  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ## container management
      docker
      lazydocker
      kubectl
      ## virtualization
      #virt-manager libvirt qemu
      ;
  };
}
