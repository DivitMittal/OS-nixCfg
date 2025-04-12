{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem = {pkgs, ...}: {
    devshells = {
      default = {
        packages = builtins.attrValues {
          inherit
            (pkgs)
            ## Nix
            nixd
            alejandra
            ## Kdl
            kdlfmt
            ;
        };
        commands = [
          {
            name = "hms";
            help = "Rebuilds & switches the home-manager configuration";
            command = "$OS_NIXCFG/scripts/home_rebuild.sh";
          }
          {
            name = "hmst";
            help = "Rebuilds & switches the home-manager configuration with traces";
            command = "$OS_NIXCFG/scripts/home_rebuild.sh trace";
          }
          {
            name = "hts";
            help = "Rebuilds & switches the host (nix-darwin, nixos, nix-on-droid) configuration";
            command = "$OS_NIXCFG/scripts/hosts_rebuild.sh";
          }
          {
            name = "htst";
            help = "Rebuilds & switches the host (nix-darwin, nixos, nix-on-droid) configuration with traces";
            command = "$OS_NIXCFG/scripts/hosts_rebuild.sh trace";
          }
        ];
      };
    };
  };
}