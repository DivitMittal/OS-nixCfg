{
  common-on,
  common-permissions,
  common-actions,
  environment,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/darwin-build.yml" = {
    on =
      common-on
      // rec {
        push = {
          branches = ["master"];
          paths-ignore =
            common-on.push.paths-ignore
            ++ [
              ## common
              "common/home/**"
              "common/hosts/droid/**"
              "common/hosts/nixos/**"
              ## configuration
              "home/**"
              "hosts/droid/**"
              "hosts/nixos/**"
              ## modules
              "modules/home/**"
              "modules/hosts/droid/**"
              "modules/hosts/nixos/**"
            ];
        };
        pull_request = push;
      };
    jobs.build-nix-darwin-configuration = {
      permissions = common-permissions;
      inherit environment;
      steps =
        common-actions
        ++ [
          {
            name = "Builds a nix-darwin configuration";
            run = "nix -vL build --accept-flake-config .#darwinConfigurations.L1.config.system.build.toplevel --impure --show-trace";
          }
        ];
    };
  };
}
