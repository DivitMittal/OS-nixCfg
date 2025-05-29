{lib, ...}: let
  inherit (lib) mkDefault;
in {
  nix.optimise.interval = mkDefault [
    # Every Sunday 10:00PM
    {
      Hour = 22;
      Minute = 00;
      Weekday = 0;
    }
  ];
}