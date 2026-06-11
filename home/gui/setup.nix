{
  lib,
  inputs,
  hostPlatform,
  ...
}: {
  imports =
    [(inputs.import-tree ./ide)]
    ++ [(inputs.import-tree ./music)]
    ++ [
      ./comms.nix
      ./ebooks.nix
      ./misc.nix
      ./notes.nix
      ./office.nix
      ./video.nix
    ]
    ++ lib.lists.optionals hostPlatform.isDarwin [(inputs.import-tree ./darwin)]
    ++ lib.lists.optionals hostPlatform.isLinux [(inputs.import-tree ./linux)];
}
