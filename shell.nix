# Custom shell for bootstrapping on new hosts/modifying nix-config
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
      config = {
        allowUnfree = true;
        allowBroken = false;
        allowUnsupportedSystem = false;
        allowInsecure = true;
      };
    },
  lib ? pkgs.lib,
  ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes\naccept-flake-config = true";

    nativeBuildInputs = lib.attrsets.attrValues {
      inherit
        (pkgs)
        nix
        direnv
        home-manager
        git
        openssh
        ;
    };

    shellHook = ''
      export DIRENV_CONFIG="$PWD/.direnv-config"
      mkdir -p "$DIRENV_CONFIG"
      echo 'source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc' > "$DIRENV_CONFIG/direnvrc"
    '';
  };
}
