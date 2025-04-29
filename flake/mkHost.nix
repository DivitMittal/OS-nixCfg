{
  inputs,
  self,
  ...
}: let
  mkHost = {
    hostName,
    system,
    class,
    additionalModules ? [],
    extraSpecialArgs ? {},
  }: let
    configGenerator = {
      darwin = inputs.nix-darwin.lib.darwinSystem;
      nixos = inputs.nixpkgs.lib.nixosSystem;
      droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration;
      home = inputs.home-manager.lib.homeManagerConfiguration;
    };
    systemFunc = configGenerator.${class};
    #lib = inputs.nixpkgs.lib; # unextended
    # ========== Extend lib with lib.custom ==========
    # NOTE: This approach allows lib.custom to propagate into hm
    # see: https://github.com/nix-community/home-manager/pull/3454
    lib = inputs.nixpkgs.lib.extend (_: _: {custom = import (self + /lib) {inherit (inputs.nixpkgs) lib;};} // inputs.home-manager.lib); # extended
    #pkgs = import inputs.nixpkgs { inherit system; overlays = [ ]; }; # not-memoized
    pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
    specialArgs =
      {
        inherit self inputs;
        mypkgs = inputs.mynixpkgs.legacyPackages.${system};
        pkgs-master = inputs.nixpkgs-master.legacyPackages.${system};
        inherit (pkgs.stdenvNoCC) hostPlatform;
      }
      // extraSpecialArgs;
    modules =
      [
        (self + /nix.nix)
        (self + /modules/common)
        {
          hostSpec = {
            inherit (inputs.OS-nixCfg-secrets.user) username userFullName handle email;
            inherit hostName;
          };
        }
      ]
      ++ lib.optionals (class == "darwin" || class == "nixos" || class == "droid") [
        (self + /modules/hosts/${class})
        (self + /hosts/${class}/common)
        (self + /hosts/${class}/${hostName})
      ]
      ++ lib.optionals (class == "darwin" || class == "nixos") [
        (self + /hosts/common)
      ]
      ++ lib.optionals (class == "home") [
        (self + /modules/home)
        (self + /home/common)
      ]
      ++ lib.optionals (class == "home" && lib.strings.hasSuffix "darwin" system) [
        {
          nixpkgs = {
            overlays = [
              inputs.brew-nix.overlays.default
            ];
          };
        }
      ]
      ++ additionalModules;
  in
    systemFunc (
      {
        inherit pkgs;
        inherit lib;
        inherit modules;
      }
      // (lib.attrsets.optionalAttrs (class == "darwin" || class == "nixos") {inherit specialArgs;})
      // (lib.attrsets.optionalAttrs (class == "home") {extraSpecialArgs = specialArgs;})
      // (lib.attrsets.optionalAttrs (class == "droid") {
        extraSpecialArgs = specialArgs;
        home-manager-path = inputs.home-manager.outPath;
      })
    );
in {
  _module.args = {
    inherit mkHost;
  };
}
