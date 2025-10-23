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
      ./notes.nix
      ./music.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [
      ./darwin
    ];
}
