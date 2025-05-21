{
  self,
  inputs,
  lib,
  ...
} @ args: let
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
    ## ====== Extended lib ======
    lib = args.lib.extend (self.outputs.overlay.lib.default);
    ## ====== pkgs ======
    #pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
    ## non-memoized pkgs
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
          self.outputs.overlay.pkgs.default
        ]
        ++ lib.lists.optionals (class == "darwin") [
          self.outputs.overlay.pkgs.darwin-pkgs
        ]
        ++ lib.lists.optionals (class == "nixos") [
          self.outputs.overlay.pkgs.nixos-pkgs
        ]
        ++ lib.lists.optionals (class == "home" && lib.strings.hasSuffix "darwin" system) [
          inputs.brew-nix.overlays.default
          inputs.nixpkgs-firefox-darwin.overlay
          self.outputs.overlay.pkgs.darwin-pkgs
        ]
        ++ lib.lists.optionals (class == "home" && lib.strings.hasSuffix "linux" system) [
          self.outputs.overlay.pkgs.nixos-pkgs
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
      (lib.attrsets.optionalAttrs
        (class == "darwin" || class == "nixos")
        {inherit specialArgs;})
      (lib.attrsets.optionalAttrs
        (class == "home")
        {extraSpecialArgs = specialArgs;})
      (lib.attrsets.optionalAttrs
        (class == "droid")
        {
          extraSpecialArgs = specialArgs;
          home-manager-path = inputs.home-manager.outPath;
        })
    ]);
in {
  _module.args = {
    inherit mkHost;
  };
}