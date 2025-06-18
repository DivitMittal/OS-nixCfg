{
  lib,
  hostPlatform,
  ...
}: {
  imports =
    [
      ./emulators
      ./viewers.nix
      ./misc.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [
      ./darwin
    ];
}