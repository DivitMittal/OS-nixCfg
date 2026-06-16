{
  pkgs,
  lib,
  config,
  hostPlatform,
  ...
}: {
  # colima manages Lima VMs; macOS-only (launchd-backed)
  # isService = false → no launchd agent; start manually with `colima start`
  services.colima = lib.mkIf hostPlatform.isDarwin {
    enable = true;
    colimaHomeDir = "${config.xdg.configHome}/colima";
    coreutilsPackage = pkgs.uutils-coreutils;
    profiles.default = {
      isService = false;
      settings = {
        runtime = "docker";

        cpu = 6;
        memory = 6;
        disk = 10;

        kubernetes.enabled = false;

        # vz: Apple Virtualization.framework — native on Apple Silicon (macOS 12+),
        # requires macOS 13 on Intel; fall back to qemu on x86 for compatibility.
        vmType =
          if hostPlatform.isAarch64
          then "vz"
          else "qemu";
      };
    };
  };

  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ### container management
      ## docker
      docker
      docker-compose
      lazydocker
      ## kubernetes
      kubectl
      ### virtualization
      #virt-manager libvirt qemu
      ;

    ## kubernetes
    # k9s 0.51.0 tests write to /tmp which the Nix sandbox forbids
    # (permission denied in TestEnsureBenchmarkCfg/TestSkinFileFromName/
    # TestK9sReload); skip the check phase to build.
    k9s = pkgs.k9s.overrideAttrs (_: {doCheck = false;});
  };
}
