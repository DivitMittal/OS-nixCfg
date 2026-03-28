{
  lib,
  inputs,
  hostPlatform,
  ...
}: {
  imports =
    (inputs.import-tree ./emulators)
    ++ (inputs.import-tree ./ide)
    ++ (inputs.import-tree ./music)
    ++ [
      ./comms.nix
      ./misc.nix
      ./notes.nix
      ./video.nix
      ./viewers.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin (inputs.import-tree ./darwin)
    ++ lib.lists.optionals hostPlatform.isLinux (inputs.import-tree ./linux);
}
