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
      mole = lib.custom.mkZbxBin "mole";
      mac-cleanup = lib.custom.mkUvxBin "mac-cleanup" "mac-cleanup";
    });
}
