{
  self,
  inputs,
  lib,
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
      nixos = lib.nixosSystem;
      darwin = inputs.nix-darwin.lib.darwinSystem;
      droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration;
      home = inputs.home-manager.lib.homeManagerConfiguration;
    };
    ## ====== pkgs ======
    #pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
    # non-memoized
    pkgs = builtins.import inputs.nixpkgs {
      inherit system;
      config = let
        inherit (lib) mkDefault;
      in {
        allowUnfree = mkDefault true;
        allowBroken = mkDefault false;
        allowUnsupportedSystem = mkDefault false;
        allowInsecure = mkDefault true;
        checkMeta = mkDefault false;
        warnUndeclaredOptions = mkDefault true;
      };
      overlays =
        [
          self.outputs.overlays.default
          self.outputs.overlays.pkgs-master
        ]
        ++ lib.lists.optionals (lib.strings.hasSuffix "darwin" system) [
          self.outputs.overlays.pkgs-darwin
        ]
        ++ lib.lists.optionals (lib.strings.hasSuffix "linux" system) [
          self.outputs.overlays.pkgs-nixos
        ];
    };
    inherit (pkgs.stdenvNoCC) hostPlatform;
    specialArgs = {inherit self inputs hostPlatform;} // extraSpecialArgs;
    modules =
      [
        ## ====== nix.conf ======
        ../conf.nix
        ## ===== OS-nixCfg-secrets ======
        inputs.OS-nixCfg-secrets.modules.hostSpec
        {
          hostSpec = {
            inherit (inputs.OS-nixCfg-secrets.user) username userFullName handle email;
            inherit hostName;
          };
        }
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
      {inherit modules;}
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
    ]);
in {
  _module.args = {
    inherit mkHost;
  };
}