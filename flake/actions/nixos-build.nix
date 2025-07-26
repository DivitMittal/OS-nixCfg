{
  common-on,
  common-permissions,
  environment,
  common-actions,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/nixos-build.yml" = {
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
              "common/hosts/darwin/**"
              ## configuration
              "home/**"
              "hosts/droid/**"
              "hosts/darwin/**"
              ## modules
              "modules/home/**"
              "modules/hosts/droid/**"
              "modules/hosts/darwin/**"
            ];
        };
        pull_request = push;
      };
    jobs.build-nixos-configuration = {
      runs-on = "ubuntu-latest";
      permissions = common-permissions;
      inherit environment;
      steps =
        common-actions
        ++ [
          {
            name = "Builds a nixos configuration";
            run = "nix -vL build --accept-flake-config .#nixosConfigurations.WSL.config.system.build.toplevel --impure --show-trace";
          }
        ];
    };
  };
}
