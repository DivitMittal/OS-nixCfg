{
  lib,
  hostPlatform,
  ...
}: {
  imports =
    [
      ./emulators
      ./ide
      ./comms.nix
      ./music.nix
      ./notes.nix
      ./video.nix
      ./viewers.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [
      ./darwin
    ]
    ++ lib.lists.optionals hostPlatform.isLinux [
      ./linux
    ];
}
