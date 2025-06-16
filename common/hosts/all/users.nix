{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.home-manager];

  users.users = {
    "${config.hostSpec.username}" = {
      description = "${config.hostSpec.username}@${config.hostSpec.hostName}";
      inherit (config.hostSpec) home;
      createHome = true;
      shell = pkgs.fish;
    };
  };
}
