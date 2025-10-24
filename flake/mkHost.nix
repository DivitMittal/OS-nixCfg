{
  inputs,
  lib,
  withSystem,
  self,
  ...
} @ args: let
  mkHost = {
    hostName,
    class,
    system,
    additionalModules ? [],
    extraSpecialArgs ? {},
  }:
    withSystem system (ctx: let
      configGenerator = {
        nixos = lib.nixosSystem;
        darwin = inputs.nix-darwin.lib.darwinSystem;
        droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration;
        home = inputs.home-manager.lib.homeManagerConfiguration;
      };
      inherit (ctx.pkgs.stdenvNoCC) hostPlatform;
      pkgs = ctx.pkgs.extend (
        self: super:
          lib.attrsets.mergeAttrsList [
            (args.self.outputs.overlays.pkgs-nixos self super)
            (inputs.nur.overlays.default self super)
            (lib.attrsets.optionalAttrs hostPlatform.isDarwin (
              args.self.outputs.overlays.pkgs-darwin self super
            ))
          ]
      );
      specialArgs = {inherit self inputs hostPlatform;} // extraSpecialArgs;
      modules = let
        commonDir = self + "/common";
      in
        [{hostSpec = {inherit hostName;};}]
        ++ lib.lists.optionals (class == "darwin" || class == "nixos") [
          (commonDir + "/all")
          (commonDir + "/hosts/all")
        ]
        ++ lib.lists.optionals (class == "darwin" || class == "nixos" || class == "droid") [
          (commonDir + "/hosts/${class}")
          (self + "/hosts/${class}/${hostName}")
        ]
        ++ lib.lists.optionals (class == "home") [
          (commonDir + "/all")
          (commonDir + "/home")
        ]
        ++ lib.lists.optionals (class == "droid") [
          (commonDir + "/all/hostSpec.nix")
        ]
        ++ lib.lists.optionals (class == "nixos") [
          inputs.nix-topology.nixosModules.default
        ]
        ++ additionalModules;
    in
      configGenerator.${class} (lib.attrsets.mergeAttrsList [
        {inherit pkgs modules;}
        (lib.attrsets.optionalAttrs (class == "nixos" || class == "darwin") {inherit specialArgs lib;})
        (
          lib.attrsets.optionalAttrs (class == "home") (lib.attrsets.mergeAttrsList [
            {
              inherit lib;
              extraSpecialArgs = specialArgs;
            }
            (
              lib.attrsets.optionalAttrs hostPlatform.isDarwin {
                pkgs = pkgs.extend (self: super: (inputs.brew-nix.overlays.default self super));
              }
            )
          ])
        )
        (
          lib.attrsets.optionalAttrs (class == "droid") {
            extraSpecialArgs = specialArgs // {inherit lib;};
            home-manager-path = inputs.home-manager.outPath;
          }
        )
      ]));
in {
  _module.args = {
    inherit mkHost;
  };
}
