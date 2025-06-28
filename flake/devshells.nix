{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.devshell.flakeModule];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devshells.default = {
      devshell = rec {
        name = "OS-nixCfg";
        motd = "{202}Welcome to {91}${name} {202}devshell!{reset} \n $(menu)";
        startup = {
          git-hooks.text = ''
            ${config.pre-commit.installationScript}
          '';
        };
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
            # nix-visualize # (handled by GitHub Actions CI workflow)
            ;
        };
      };
      env = [
        {
          name = "OS_NIXCFG";
          eval = "$(pwd)";
        }
      ];
      commands = [
        {
          name = "hms";
          help = "Rebuilds & switches the home-manager configuration";
          command = "$OS_NIXCFG/utils/home_rebuild.sh";
          category = "home-manager";
        }
        {
          name = "hmst";
          help = "Rebuilds & switches the home-manager configuration with traces";
          command = "$OS_NIXCFG/utils/home_rebuild.sh trace";
          category = "home-manager";
        }
        {
          name = "hts";
          help = "Rebuilds & switches the host (nix-darwin, nixos, nix-on-droid) configuration";
          command = "$OS_NIXCFG/utils/hosts_rebuild.sh";
          category = "hosts";
        }
        {
          name = "htst";
          help = "Rebuilds & switches the host (nix-darwin, nixos, nix-on-droid) configuration with traces";
          command = "$OS_NIXCFG/utils/hosts_rebuild.sh trace";
          category = "hosts";
        }
        (lib.mkIf
          pkgs.stdenvNoCC.hostPlatform.isDarwin
          {
            name = "apps-backup";
            help = "Backup installed applications";
            command = ''
              [ -d "$OS_NIXCFG/hosts/darwin/$(hostname)/programs/bak" ] || { echo "Backup directory doesn't exist"; exit 1; }
              FILE="$OS_NIXCFG/hosts/darwin/$(hostname)/programs/bak/apps_$(date +%b%y).txt"
              /usr/bin/env ls /Applications/ 1> $FILE
              /usr/bin/env ls "$HOME/Applications/Home Manager Apps/" 1>> $FILE
            '';
            category = "misc";
          })
      ];
    };
  };
}
