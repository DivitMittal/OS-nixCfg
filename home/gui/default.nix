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
      ./video.nix
      ./email.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [
      ./darwin
    ]
    ++ lib.lists.optionals hostPlatform.isLinux [
      ./linux
    ];
}
