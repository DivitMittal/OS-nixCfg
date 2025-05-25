{
  config,
  hostPlatform,
  inputs,
  ...
}: {
  imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

  environment.variables.HOMEBREW_NO_ENV_HINTS = "1";

  homebrew = {
    enable = true;
    brewPrefix =
      if hostPlatform.isAarch
      then "/opt/homebrew/bin"
      else "/usr/local/bin";
    global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      extraFlags = ["--verbose"];
    };
    caskArgs = {
      require_sha = false;
    };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta =
      if hostPlatform.isAarch
      then true
      else false;
    user = config.hostSpec.username;
    mutableTaps = true;
    autoMigrate = true;
  };
}