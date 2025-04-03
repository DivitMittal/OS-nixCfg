# Custom shell for bootstrapping on new hosts, modifying nix-config
{
  system ? builtins.currentSystem,
  pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {
      inherit system;
      overlays = [];
    },
  ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";

    nativeBuildInputs = builtins.attrValues {
      inherit
        (pkgs)
        nix
        home-manager
        git
        pre-commit
        ;
    };
  };
}