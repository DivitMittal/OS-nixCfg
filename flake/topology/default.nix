{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.nix-topology.flakeModule
  ];

  perSystem = _: {
    topology = {
      modules = [
        ./global.nix
        # Pass the nixosConfigurations so topology can discover them
        {
          inherit (self) nixosConfigurations;
        }
      ];
    };
  };
}
