{
  inputs,
  lib,
  withSystem,
  self,
  ...
}: let
  mkCfg = {
    hostName,
    class,
    system,
    additionalModules ? [],
    extraSpecialArgs ? {},
  }:
    withSystem system (ctx: let
      configGenerator = rec {
        nixos = lib.nixosSystem;
        darwin = inputs.nix-darwin.lib.darwinSystem;
        droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration;
        home = inputs.home-manager.lib.homeManagerConfiguration;
        iso = nixos;
      };
      inherit (ctx.pkgs.stdenvNoCC) hostPlatform;
      inherit (lib.attrsets) optionalAttrs mergeAttrsList;
      pkgs = ctx.pkgs.extend (
        self: super:
          mergeAttrsList [
            {
              master = inputs.nixpkgs-master.legacyPackages.${hostPlatform.system};
              nixosStable = inputs.nixpkgs-nixos.legacyPackages.${hostPlatform.system};
            }
            (optionalAttrs hostPlatform.isDarwin {
              darwinStable = inputs.nixpkgs-darwin.legacyPackages.${hostPlatform.system};
            })
            (
              optionalAttrs (class == "home") (mergeAttrsList [
                (inputs.nur.overlays.default self super)
                (optionalAttrs hostPlatform.isDarwin (inputs.brew-nix.overlays.default self super))
              ])
            )
            (optionalAttrs (class == "droid") (inputs.nix-on-droid.overlays.default self super))
          ]
      );
      specialArgs = {inherit self inputs hostPlatform;} // extraSpecialArgs;
      modules = let
        commonDir = self + "/common";
        inherit (lib.lists) optionals;
      in
        [{hostSpec = {inherit hostName;};}]
        ++ optionals (class != "droid") [(commonDir + "/all")]
        ++ optionals (class == "droid") [(commonDir + "/all/hostSpec.nix")]
        ++ optionals (class != "home" && class != "droid") [(commonDir + "/hosts/all")]
        ++ optionals (class == "home") [
          (commonDir + "/home")
          self.outputs.homeManagerModules.default
        ]
        ++ optionals (class != "home") [
          (commonDir + "/hosts/${class}")
          (self + "/hosts/${class}/${hostName}")
        ]
        ++ optionals (class == "iso") [(commonDir + "/hosts/nixos")]
        ++ optionals (class == "nixos") [
          inputs.nix-topology.nixosModules.default
        ]
        ++ optionals (class == "darwin") [
          self.outputs.darwinModules.default
        ]
        ++ additionalModules;
    in
      configGenerator.${class} (mergeAttrsList [
        {inherit pkgs modules;}
        (optionalAttrs (class != "droid" && class != "home") {inherit specialArgs;})
        (optionalAttrs (class != "droid") {inherit lib;})
        (
          optionalAttrs (class == "home") {
            extraSpecialArgs = specialArgs;
          }
        )
        (
          optionalAttrs (class == "droid") {
            extraSpecialArgs = specialArgs // {inherit lib;};
          }
        )
      ]));
in {
  _module.args = {
    inherit mkCfg;
  };
}
