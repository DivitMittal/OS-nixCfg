{
  inputs,
  lib,
  ...
}: {
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
          ;

        apps-backup =
          if pkgs.stdenvNoCC.hostPlatform.isDarwin
          then
            (pkgs.writeShellScriptBin "apps-backup" ''
              [ -n "$OS_NIXCFG" ] || { echo "OS_NIXCFG is not set"; exit 1; }
              [ -d "$OS_NIXCFG/hosts/darwin/$(hostname)/apps/bak" ] || { echo "Backup directory doesn't exist"; exit 1; }
              FILE="$OS_NIXCFG/hosts/darwin/$(hostname)/apps/bak/apps_$(date +%b%y).txt"
              /usr/bin/env ls /Applications/ 1> $FILE
              /usr/bin/env ls "$HOME/Applications/Home Manager Apps/" 1>> $FILE
            '')
          else pkgs.hello;
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
