{
  common-on,
  common-permissions,
  common-actions,
  environment,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/topology-build.yml" = {
    on =
      common-on
      // rec {
        push = {
          branches = ["master"];
          paths-ignore =
            common-on.push.paths-ignore
            ++ [
              ## Topology outputs (don't rebuild on topology changes)
              "assets/topology/**"
            ];
          paths = [
            ## Topology configuration
            "topology/**"
            "hosts/nixos/*/topology.nix"
            ## Flake topology module
            "flake/topology.nix"
            ## Host configurations
            "hosts/nixos/**"
            "flake/mkHost.nix"
          ];
        };
        pull_request = push;
      };
    jobs.build-topology-and-commit = {
      runs-on = "ubuntu-latest"; # Topology requires Linux
      permissions = common-permissions;
      inherit environment;
      steps =
        common-actions
        ++ [
          {
            name = "Build topology visualization";
            run = "nix -vL build --accept-flake-config .#topology.x86_64-linux.config.output --impure --show-trace";
          }
          {
            name = "Create assets directory for topology";
            run = "mkdir -p ./assets/topology";
          }
          {
            name = "Copy topology SVGs to assets";
            run = ''
              # Copy all generated SVG files
              cp -v result/*.svg ./assets/topology/ || true
              # List what was copied
              ls -lh ./assets/topology/
            '';
          }
          {
            name = "Commit topology visualizations";
            run = ''
              git config --global user.name "GitHub Actions Bot"
              git config --global user.email bot@github.com
              git add assets/topology/
              # Only commit if there are changes
              git diff --staged --quiet || git commit -m "chore: update topology visualizations"
              git push origin master || echo "No changes to push"
            '';
            env = {
              GITHUB_TOKEN = "\${{ secrets.GITHUB_TOKEN }}";
            };
          }
        ];
    };
  };
}
