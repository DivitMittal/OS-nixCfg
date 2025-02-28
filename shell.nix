# Custom shell for bootstrapping on new hosts, modifying nix-config
{ pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./hosts/flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in import nixpkgs { system = builtins.currentSystem; },
  ...
}:

{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";

    nativeBuildInputs = builtins.attrValues {
      inherit (pkgs)
        nix
        git pre-commit
        home-manager
      ;
    };
  };
}