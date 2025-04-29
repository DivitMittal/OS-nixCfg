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
    ++ lib.optionals hostPlatform.isDarwin [
      ./darwin
    ];
}