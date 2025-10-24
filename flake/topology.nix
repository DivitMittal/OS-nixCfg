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
      # Automatically includes all NixOS configurations that have topology enabled
      # The nix-topology flakeModule automatically discovers NixOS configurations
      # from self.nixosConfigurations and includes those with topology.self defined

      modules = [
        # Global topology definitions (networks, non-NixOS devices, etc.)
        ../topology
        # Pass the nixosConfigurations so topology can discover them
        {
          inherit (self) nixosConfigurations;
        }
      ];
    };

    # Expose topology rendering packages
    # The topology output is accessed via config.topology.${system}.config.output
    # However, flake-parts perSystem already provides the correct system context
    # So we just need to expose the packages properly
  };
}
