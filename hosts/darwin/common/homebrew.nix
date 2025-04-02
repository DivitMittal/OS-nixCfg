{ config, hostPlatform, ...  }:

{
  environment.variables.HOMEBREW_NO_ENV_HINTS = "1";

  homebrew = {
    brewPrefix = if hostPlatform.isAarch64 then "/opt/homebrew/bin" else "/usr/local/bin";
    global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      extraFlags = [ "--verbose" ];
    };
    caskArgs = {
      require_sha = false;
    };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = if hostPlatform.isAarch64 then true else false;
    user = config.hostSpec.username;
    mutableTaps = true;
    autoMigrate = true;
  };
}