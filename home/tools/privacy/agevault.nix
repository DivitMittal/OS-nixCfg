{
  pkgs,
  lib,
  config,
  ...
}: {
  launchd.agents.agevault-lock = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.custom.agevault}/bin/agevault"
        "2025"
        "lock"
      ];
      WorkingDirectory = "${config.home.homeDirectory}/PKMS/Vaults";
      StartCalendarInterval = {
        Minute = 0;
      };
    };
  };

  home.packages = lib.attrsets.attrValues {
    inherit (pkgs.custom) agevault;
  };
}
