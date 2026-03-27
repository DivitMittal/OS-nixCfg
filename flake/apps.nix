{
  inputs,
  lib,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (pkgs.stdenvNoCC) hostPlatform;

    homeDir =
      if hostPlatform.isDarwin
      then "/Users/div"
      else "/home/div";

    ## Defines the hostSpec option type inline, replacing common/all/hostSpec.nix
    ## (which pulls from the private secrets input). Values are hardcoded stubs —
    ## sufficient for package enumeration; secret-backed config files won't activate.
    hostSpecStub = {lib, ...}: {
      options.hostSpec = with lib; {
        username = mkOption {type = types.str;};
        userFullName = mkOption {type = types.str;};
        handle = mkOption {type = types.str;};
        home = mkOption {type = types.str;};
        hostName = mkOption {type = types.str;};
        email = {
          dev = mkOption {type = types.str;};
          personal = mkOption {type = types.str;};
        };
      };
      config.hostSpec = {
        username = "div";
        userFullName = "Divit Mittal";
        handle = "DivitMittal";
        home = homeDir;
        hostName = "env";
        email = {
          dev = "div@env.local";
          personal = "div@env.local";
        };
      };
    };

    ## Evaluate a home-manager config directly in perSystem, bypassing withSystem
    ## to avoid the circular dependency that mkCfg introduces.
    mkEnvApp = name: additionalModules: let
      cfg = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs lib;
        extraSpecialArgs = {inherit inputs self hostPlatform;};
        modules =
          [
            hostSpecStub
            (self + "/common/home") # hm.nix, helpers.nix, age.nix, conf.nix
            self.outputs.homeManagerModules.default
          ]
          ++ additionalModules;
      };
      env = pkgs.buildEnv {
        name = "${name}-env";
        paths = lib.filter (p: p != null) cfg.config.home.packages;
        pathsToLink = ["/bin" "/share"];
        ignoreCollisions = true;
      };
    in {
      type = "app";
      program = toString (pkgs.writeShellScript name ''
        export PATH="${env}/bin:$PATH"
        exec "''${SHELL:-${pkgs.bashInteractive}/bin/bash}"
      '');
    };
  in {
    apps =
      {
        tty = mkEnvApp "tty" [(self + "/home/tty")];
      }
      ## Desktop is Linux-only — compositor stack doesn't exist on Darwin
      // lib.optionalAttrs hostPlatform.isLinux {
        desktop = mkEnvApp "desktop" [
          (self + "/home/tty")
          (self + "/home/gui/linux")
        ];
      };
  };
}
