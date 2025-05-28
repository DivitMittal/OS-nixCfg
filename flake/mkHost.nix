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
    withSystem system (ctx @ {pkgs, ...}: let
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
            (lib.attrsets.optionalAttrs (hostPlatform.isDarwin) (
              args.self.outputs.overlays.pkgs-darwin self super
            ))
            (lib.attrsets.optionalAttrs (hostPlatform.isLinux) (
              args.self.outputs.overlays.pkgs-nixos self super
            ))
          ]
      );
      specialArgs = {inherit self inputs hostPlatform;} // extraSpecialArgs;
      modules =
        [
          ../common
          {hostSpec = {inherit hostName;};}
        ]
        ++ lib.lists.optionals (class == "darwin" || class == "nixos" || class == "droid") [
          ../hosts/${class}/common
          ../hosts/${class}/${hostName}
        ]
        ++ lib.lists.optionals (class == "darwin" || class == "nixos") [
          ../hosts/common
        ]
        ++ lib.lists.optionals (class == "home") [
          self.outputs.homeManagerModules.default
          ../home/common
        ]
        ++ lib.lists.optionals (class == "darwin") [
          self.outputs.darwinModules.default
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
              lib.attrsets.optionalAttrs (hostPlatform.isDarwin) {
                pkgs = pkgs.extend (self: super:
                  lib.attrsets.mergeAttrsList [
                    (inputs.brew-nix.overlays.default self super)
                    (inputs.nixpkgs-firefox-darwin.overlay self super)
                  ]);
              }
            )
          ])
        )
        (
          lib.attrsets.optionalAttrs (class == "droid") {
            extraSpecialArgs = specialArgs;
            home-manager-path = inputs.home-manager.outPath;
          }
        )
      ]));
in {
  _module.args = {
    inherit mkHost;
  };
}