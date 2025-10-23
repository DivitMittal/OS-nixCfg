{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues ({
      librescore = pkgs.writeShellScriptBin "librescore" ''
        exec ${pkgs.pnpm}/bin/pnpm dlx dl-librescore@latest "$@"
      '';
    }
    // lib.attrsets.optionalAttrs hostPlatform.isLinux {
      # inherit
      #   (pkgs)
      #   reaper-sws-extension
      #   reaper-reapack-extension
      #   ;
    });
}
