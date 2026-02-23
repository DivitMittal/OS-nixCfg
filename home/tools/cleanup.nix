{
  pkgs,
  lib,
  hostPlatform,
  ...
}: {
  home.packages =
    (lib.attrsets.attrValues {
      inherit
        (pkgs)
        kondo
        czkawka-full
        ;
    })
    ++ lib.lists.optionals hostPlatform.isDarwin (lib.attrsets.attrValues {
      inherit
        (pkgs.customDarwin)
        mole-bin
        ;
      mac-cleanup = pkgs.writeShellScriptBin "mac-cleanup" ''
        exec ${pkgs.uv}/bin/uvx mac-cleanup "$@"
      '';
    });
}
