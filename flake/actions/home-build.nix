{
  common-on,
  common-permissions,
  common-actions,
  environment,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/home-build.yml" = {
    on =
      common-on
      // rec {
        push = {
          branches = ["master"];
          paths-ignore =
            common-on.push.paths-ignore
            ++ [
              ## common
              "common/hosts/**"
              ## configuration
              "hosts/**"
              ## modules
              "modules/hosts/**"
            ];
        };
        pull_request = push;
      };
    jobs.build-home-manager-and-graph = {
      permissions = common-permissions;
      inherit environment;
      steps =
        common-actions
        ++ [
          {
            name = "Builds a home-manager configuration";
            run = "nix -vL build --accept-flake-config .#homeConfigurations.L1.activationPackage --impure --show-trace";
          }
          {
            name = "Generate home-manager dependency graph";
            run = "nix -vL run github:craigmbooth/nix-visualize -- --verbose --output ./assets/home_graph.png ./result";
          }
          {
            name = "Push to repo";
            run = ''
              git config --global user.name "GitHub Actions Bot"
              git config --global user.email bot@github.com
              git add .
              git commit -m "chore: update home-manager dependency graph"
              git push origin master
            '';
            env = {
              GITHUB_TOKEN = "\${{ secrets.GITHUB_TOKEN }}";
            };
          }
        ];
    };
  };
}
