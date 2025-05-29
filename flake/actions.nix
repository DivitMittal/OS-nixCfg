{inputs, ...}: {
  imports = [inputs.actions-nix.flakeModules.default];

  flake.actions-nix = {
    pre-commit.enable = true;
    defaults = {
      jobs = {
        runs-on = "macos-latest";
        timeout-minutes = 30;
      };
    };

    workflows = let
      on = {
        push = {
          branches = ["master"];
          paths-ignore = [
            "**/*.md"
            ".github/**"
          ];
        };
        pull_request = {
          branches = ["master"];
        };
        workflow_dispatch = {};
      };
      environment = {
        name = "dev";
      };
      common-actions = [
        {
          name = "Checkout repo";
          uses = "actions/checkout@main";
          "with" = {
            fetch-depth = 1;
          };
        }
        {
          name = "Set env var";
          run = "echo \"OS_NIXCFG=$(pwd)\" >> \"$GITHUB_ENV\"";
        }
        inputs.actions-nix.lib.steps.DeterminateSystemsNixInstallerAction
        {
          name = "Configure to use personal binary cache @ Cachix";
          uses = "cachix/cachix-action@master";
          "with" = {
            name = "divitmittal";
            authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
          };
        }
        {
          name = "SSH-agent with auth for private repos";
          uses = "webfactory/ssh-agent@master";
          "with" = {
            ssh-private-key = "\${{ secrets.SSH_PRIVATE_KEY }}";
          };
        }
      ];
    in {
      ".github/workflows/darwin-build.yml" = {
        inherit on;
        jobs.build-nix-darwin-configuration = {
          inherit environment;
          permissions.contents = "write";
          steps =
            common-actions
            ++ [
              {
                name = "Builds a nix-darwin configuration";
                run = "nix build --accept-flake-config .#darwinConfigurations.L1.config.system.build.toplevel --impure --show-trace";
              }
            ];
        };
      };

      ".github/workflows/nixos-build.yml" = {
        inherit on;
        jobs.build-nixos-configuration = {
          runs-on = "ubuntu-latest";
          inherit environment;
          permissions.contents = "write";
          steps =
            common-actions
            ++ [
              {
                name = "Builds a nixos configuration";
                run = "nix build --accept-flake-config .#nixosConfigurations.WSL.config.system.build.toplevel --impure --show-trace";
              }
            ];
        };
      };

      ".github/workflows/home-build.yml" = {
        inherit on;
        jobs.build-home-manager-configuration = {
          inherit environment;
          permissions.contents = "write";
          steps =
            common-actions
            ++ [
              {
                name = "Builds a home-manager configuration";
                run = "nix build --accept-flake-config .#homeConfigurations.L1.activationPackage --impure --show-trace";
              }
            ];
        };
      };

      ".github/workflows/droid-build.yml" = {
        inherit on;
        jobs.build-nix-on-droid-configuration = {
          runs-on = "ubuntu-24.04-arm";
          inherit environment;
          permissions.contents = "write";
          steps =
            common-actions
            ++ [
              {
                name = "Builds a nix-on-droid configuration";
                run = "nix build --accept-flake-config .#nixOnDroidConfigurations.M1.config.build.activationPackage --impure --show-trace";
              }
            ];
        };
      };

      ".github/workflows/flake-check.yml" = {
        inherit on;
        jobs.checking-flake = {
          runs-on = "ubuntu-latest";
          inherit environment;
          steps =
            common-actions
            ++ [
              {
                name = "Run nix flake check";
                run = "nix flake check --impure --all-systems --no-build";
              }
            ];
        };
      };
    };
  };
}
