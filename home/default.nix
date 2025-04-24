{
  mkHost,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeConfigurations = let
    class = "home";
  in {
    L1 = mkHost {
      hostName = "L1";
      system = "x86_64-darwin";
      inherit class;
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

    WSL = mkHost {
      hostName = "WSL";
      system = "x86_64-linux";
      inherit class;
      additionalModules = [./tty];
    };
  };
}
