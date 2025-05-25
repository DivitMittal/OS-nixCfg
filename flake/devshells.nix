{inputs, lib, ...}: {
  imports = [inputs.devshell.flakeModule];

  perSystem = {pkgs, ...}: {
    devshells.default = {
      packages = lib.attrsets.attrValues {
        inherit
          (pkgs)
          ### LSPs & Formatters
          ## Nix
          nixd
          alejandra
          ## Kdl
          kdlfmt
          ## Shell
          shfmt
          ### Nix Tools
          nix-visualize
          nix-melt
          ;
      };
      commands = [
        {
          name = "hms";
          help = "Rebuilds & switches the home-manager configuration";
          command = "$OS_NIXCFG/utils/home_rebuild.sh";
        }
        {
          name = "hmst";
          help = "Rebuilds & switches the home-manager configuration with traces";
          command = "$OS_NIXCFG/utils/home_rebuild.sh trace";
        }
        {
          name = "hts";
          help = "Rebuilds & switches the host (nix-darwin, nixos, nix-on-droid) configuration";
          command = "$OS_NIXCFG/utils/hosts_rebuild.sh";
        }
        {
          name = "htst";
          help = "Rebuilds & switches the host (nix-darwin, nixos, nix-on-droid) configuration with traces";
          command = "$OS_NIXCFG/utils/hosts_rebuild.sh trace";
        }
      ];
    };
  };
}