{inputs, ...}: {
  pkgs-master = _: super: {
    master = inputs.nixpkgs-master.legacyPackages.${super.stdenvNoCC.hostPlatform.system};
  };

  pkgs-darwin = _: super: {
    darwinStable = inputs.nixpkgs-darwin.legacyPackages.${super.stdenvNoCC.hostPlatform.system};
  };

  pkgs-nixos = _: super: {
    nixosStable = inputs.nixpkgs-nixos.legacyPackages.${super.stdenvNoCC.hostPlatform.system};
  };
}
