{ pkgs, lib, ... }:

{
  config = {
    # See <https://github.com/nix-community/home-manager/issues/3323#issuecomment-1280055087>
    launchd.agents.FirefoxEnv = {
      enable = pkgs.stdenvNoCC.hostPlatform.isDarwin;


      config = {
        ProgramArguments = [ "/bin/sh" "-c" "launchctl setenv MOZ_LEGACY_PROFILES 1; launchctl setenv MOZ_ALLOW_DOWNGRADE 1" ];
        RunAtLoad = true;
      };
    };
  };
}