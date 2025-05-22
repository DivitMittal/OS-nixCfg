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
      overlays = [
        self.outputs.overlays.default
        self.outputs.overlays.pkgs-master
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
      {inherit lib modules;}
      (
        lib.attrsets.optionalAttrs (class == "nixos") {
          pkgs = pkgs.extend (self.outputs.overlays.pkgs-nixos);
          inherit specialArgs;
        }
      )
      (
        lib.attrsets.optionalAttrs (class == "darwin") {
          pkgs = pkgs.extend (self.outputs.overlays.pkgs-darwin);
          inherit specialArgs;
        }
      )
      (
        lib.attrsets.optionalAttrs (class == "home") (lib.attrsets.mergeAttrsList [
          {extraSpecialArgs = specialArgs;}
          (
            lib.attrsets.optionalAttrs (hostPlatform.isDarwin) {
              pkgs = pkgs.extend (_: _:
                lib.attrsets.mergeAttrsList [
                  (self.outputs.overlays.pkgs-darwin _ _)
                  (inputs.brew-nix.overlays.default _ _)
                  (inputs.nixpkgs-firefox-darwin.overlay _ _)
                ]);
            }
          )
          (
            lib.attrsets.optionalAttrs (hostPlatform.isLinux) {
              pkgs = pkgs.extend (self.outputs.overlays.pkgs-nixos);
            }
          )
        ])
      )
      (
        lib.attrsets.optionalAttrs (class == "droid") {
          pkgs = pkgs.extend (self.outputs.overlays.pkgs-nixos);
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
