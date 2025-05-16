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
    ## ====== Unextended lib ======
    _lib = inputs.nixpkgs.lib;
    ## ====== pkgs ======
    #pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
    ## non-memoized pkgs
    pkgs = import inputs.nixpkgs {
      inherit system;
      config = let
        inherit (_lib) mkDefault;
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
          (import (self + /pkgs/overlay.nix))
        ]
        ++ _lib.lists.optionals (class == "home" && _lib.strings.hasSuffix "darwin" system) [
          inputs.brew-nix.overlays.default
          inputs.nixpkgs-firefox-darwin.overlay
        ];
    };
    ## ====== Extended lib ======
    lib = _lib.extend (_final: _prev:
      {
        custom = import (self + /lib) {lib = _lib;};
      }
      // (_lib.attrsets.optionalAttrs (class == "home") inputs.home-manager.lib));
    specialArgs =
      {
        inherit self inputs;
        inherit (pkgs.stdenvNoCC) hostPlatform;
      }
      // extraSpecialArgs;
    modules =
      [
        (self + /conf.nix)
        (self + /modules/common)
        {
          hostSpec = {
            inherit (inputs.OS-nixCfg-secrets.user) username userFullName handle email;
            inherit hostName;
          };
        }
      ]
      ++ (lib.lists.optionals (class == "darwin" || class == "nixos" || class == "droid") [
        (self + /modules/hosts/${class})
        (self + /hosts/${class}/common)
        (self + /hosts/${class}/${hostName})
      ])
      ++ (lib.lists.optionals (class == "darwin" || class == "nixos") [
        (self + /hosts/common)
      ])
      ++ (lib.lists.optionals (class == "home") [
        (self + /modules/home)
        (self + /home/common)
      ])
      ++ additionalModules;
  in
    systemFunc (lib.attrsets.mergeAttrsList [
      {
        inherit pkgs;
        inherit lib;
        inherit modules;
      }
      (lib.attrsets.optionalAttrs (class == "darwin" || class == "nixos") {
        inherit specialArgs;
      })
      (lib.attrsets.optionalAttrs (class == "home") {
        extraSpecialArgs = specialArgs;
      })
      (lib.attrsets.optionalAttrs (class == "droid") {
        extraSpecialArgs = specialArgs;
        home-manager-path = inputs.home-manager.outPath;
      })
    ]);
in {
  _module.args = {
    inherit mkHost;
  };
}