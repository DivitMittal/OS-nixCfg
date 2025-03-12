{ self, user, inputs, ... }:

let
 hmGenerator = system: additionalModules:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
      # pkgs = import inputs.nixpkgs { inherit system; }; # not-memoized

      # extraSpecialArgs is alter to `_module.args` for homeManagerConfiguration
      extraSpecialArgs = {
        inherit self inputs user;
      };
      modules = [
        ./common
        ./programs/tty-env
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
      ./configs/raycast

      ./programs/communication
      ./programs/development
      ./programs/keyboard
      ./programs/media
      ./programs/tools
      ./programs/virt
      ./programs/web
    ];

    L2 = hmGenerator "x86_64-linux" [];
    WSL = hmGenerator "x86_64-linux" [];
  };
}