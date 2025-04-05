{
  mkHost,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeConfigurations = {
    L1 = mkHost {
      hostName = "L1";
      system = "x86_64-darwin";
      class = "home";
      additionalModules = [
        ./comms
        ./desktop-env
        ./dev
        ./keyboard
        ./media
        ./tools
        ./tty
        ./web
      ];
    };
  };
}
