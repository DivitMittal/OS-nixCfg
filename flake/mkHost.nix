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
    ## non-memoized
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
        self.outputs.overlay.pkgs.default
      ];
    };
    specialArgs =
      {
        inherit self inputs;
        inherit (pkgs.stdenvNoCC) hostPlatform;
      }
      // extraSpecialArgs;
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
      {inherit pkgs lib modules;}
      (
        lib.attrsets.optionalAttrs (class == "nixos") {
          pkgs = pkgs.extend (self.outputs.overlay.pkgs.nixos-pkgs);
          inherit specialArgs;
        }
      )
      (
        lib.attrsets.optionalAttrs (class == "darwin") {
          pkgs = pkgs.extend (self.outputs.overlay.pkgs.darwin-pkgs);
          inherit specialArgs;
        }
      )
      (
        lib.attrsets.optionalAttrs
        (class == "home")
        lib.attrsets.mergeAttrsList [
          {extraSpecialArgs = specialArgs;}
          (
            lib.attrsets.optionalAttrs
            (lib.strings.hasSuffix "darwin" system)
            {pkgs = ((pkgs.extend (self.outputs.overlay.pkgs.darwin-pkgs)).extend (inputs.brew-nix.overlays.default)).extend (inputs.nixpkgs-firefox-darwin.overlay);}
          )
          (
            lib.attrsets.optionalAttrs
            (lib.strings.hasSuffix "linux" system)
            {pkgs = pkgs.extend (self.outputs.overlay.pkgs.nixos-pkgs);}
          )
        ]
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