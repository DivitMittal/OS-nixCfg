{
  self,
  lib,
  ...
}: {
  # Automatically generate ISO packages from nixosConfigurations
  # Only processes configurations that have isoImage in their build outputs
  perSystem = {system, ...}: {
    packages = lib.attrsets.optionalAttrs (system == "x86_64-linux") (
      lib.attrsets.mapAttrs' (
        name: config:
          lib.attrsets.nameValuePair name config.config.system.build.isoImage
      ) (
        lib.attrsets.filterAttrs (
          _name: config:
            config.config.system.build ? isoImage
        )
        self.nixosConfigurations
      )
    );
  };
}
