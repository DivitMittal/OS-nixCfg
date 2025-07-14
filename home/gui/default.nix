{
  lib,
  hostPlatform,
  ...
}: {
  imports =
    [
      ./emulators
      ./ide
      ./viewers.nix
      ./misc.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [
      ./darwin
    ];
}