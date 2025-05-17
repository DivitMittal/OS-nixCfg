{
  lib,
  hostPlatform,
  ...
}: {
  imports =
    [
      ./emulators
      ./misc.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [
      ./darwin
    ];
}
