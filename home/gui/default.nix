{
  lib,
  hostPlatform,
  ...
}: {
  imports =
    [
      ./emulators
      ./viewers.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [
      ./darwin
    ];
}