{
  inputs,
  lib,
  self,
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
        packages =
          lib.attrsets.attrValues {
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
          }
          ++ [
            inputs.deploy-rs.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default # Deploy-rs for remote deployment
          ];
      };
      commands = [
        {
          name = "hms";
          help = "Rebuilds & switches the home-manager configuration (pass flags like -v --show-trace --impure)";
          command = "${self}/utils/home_rebuild.sh \"$@\"";
          category = "home-manager";
        }
        {
          name = "hts";
          help = "Rebuilds & switches the host configuration (pass flags like -v --show-trace --impure)";
          command = "${self}/utils/hosts_rebuild.sh \"$@\"";
          category = "hosts";
        }
        (lib.mkIf
          pkgs.stdenvNoCC.hostPlatform.isDarwin
          {
            name = "apps-backup";
            help = "Backup installed applications";
            command = ''
              [ -d "${self}/hosts/darwin/$(hostname)/programs/bak" ] || { echo "Backup directory doesn't exist"; exit 1; }
              FILE="${self}/hosts/darwin/$(hostname)/programs/bak/apps_$(date +%b%y).txt"
              /usr/bin/env ls /Applications/ 1> $FILE
              /usr/bin/env ls "$HOME/Applications/Home Manager Apps/" 1>> $FILE
            '';
            category = "misc";
          })
      ];
    };
  };
}
