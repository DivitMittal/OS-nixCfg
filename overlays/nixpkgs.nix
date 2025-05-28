{inputs, ...}: let
  config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };
in {
  pkgs-master = _: _: {
    master = builtins.import inputs.nixpkgs-master {inherit config;};
  };

  pkgs-darwin = _: _: {
    darwinStable = builtins.import inputs.nixpkgs-darwin {inherit config;};
  };

  pkgs-nixos = _: _: {
    nixosStable = builtins.import inputs.nixpkgs-nixos {inherit config;};
  };
}