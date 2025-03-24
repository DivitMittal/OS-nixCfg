{ self, user, inputs, pkgs, ... }:

let
 hmGenerator = system: additionalModules:
    inputs.home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;
      ## extraSpecialArgs is alter to `_module.args` for homeManagerConfiguration
      extraSpecialArgs = {
        inherit self inputs user;
        inherit(pkgs.stdenvNoCC) hostPlatform;
      };
      modules = [
        ./common
        (self + /nix.nix)
        ./tty-env
        inputs.sops-nix.homeManagerModules.sops ./sops.nix
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