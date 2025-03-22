{ self, user, inputs, ... }:

let
 hmGenerator = system: additionalModules:
    inputs.home-manager.lib.homeManagerConfiguration rec {
      pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
      #pkgs = import inputs.nixpkgs { inherit system; }; # not-memoized

      ## extraSpecialArgs is alter to `_module.args` for homeManagerConfiguration
      extraSpecialArgs = {
        inherit self inputs user;
        hostPlatform = pkgs.stdenvNoCC.hostPlatform;
      };
      modules = [
        ./common
        # (self + ./nix.nix)
        ./../nix.nix
        ./tty-env
        inputs.sops-nix.homeManagerModules.sops
      ] ++ additionalModules;
    };
in
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeConfigurations = {
    L1 = hmGenerator "x86_64-darwin" [
      ./communication
      ./desktop-env
      ./development
      ./keyboard
      ./media
      ./tools
      ./web
    ];

    L2 = hmGenerator "x86_64-linux" [];
    WSL = hmGenerator "x86_64-linux" [];
  };
}