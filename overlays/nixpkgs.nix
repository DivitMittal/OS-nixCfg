{inputs, ...}: {
  pkgs-master = _: super: {
    master = inputs.nixpkgs-master.legacyPackages.${super.system};
  };

  pkgs-darwin = _: super: {
    darwinStable = inputs.nixpkgs-darwin.legacyPackages.${super.system};
  };

  pkgs-nixos = _: super: {
    nixosStable = inputs.nixpkgs-nixos.legacyPackages.${super.system};
  };
}