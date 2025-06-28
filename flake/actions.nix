{inputs, ...}: {
  imports = [inputs.actions-nix.flakeModules.default];

  flake.actions-nix = {
    pre-commit.enable = true;
    defaultValues = {
      jobs = {
        runs-on = "macos-latest";
        timeout-minutes = 60;
      };
    };

    workflows = let
      on = rec {
        push = {
          branches = ["master"];
          paths-ignore = [
            ## Markup
            "**/*.md"
            "**/*.adoc"
            ## Images
            "**/*.jpeg"
            "**/*.jpg"
            "**/*.png"
            "**/*.svg"
            ## Github Actions
            ".github/**"
            ## git
            ".git*"
            ## assets
            "assets/**"
          ];
        };
        pull_request = push;
        workflow_dispatch = {};
      };
      environment = {
        name = "dev";
      };
      permissions = {
        contents = "write";
        id-token = "write";
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
          run = "echo \"OS_NIXCFG=$(pwd)\" 1>> \"$GITHUB_ENV\"";
        }
        inputs.actions-nix.lib.steps.DeterminateSystemsNixInstallerAction
        {
          name = "Magic Nix Cache(Use Github Actions Cache)";
          uses = "DeterminateSystems/magic-nix-cache-action@main";
        }
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
        on =
          on
          // rec {
            push = {
              branches = ["master"];
              paths-ignore =
                on.push.paths-ignore
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
          inherit permissions;
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

      ".github/workflows/nixos-build.yml" = {
        on =
          on
          // rec {
            push = {
              branches = ["master"];
              paths-ignore =
                on.push.paths-ignore
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
          inherit permissions;
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

      ".github/workflows/home-build.yml" = {
        on =
          on
          // rec {
            push = {
              branches = ["master"];
              paths-ignore =
                on.push.paths-ignore
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
          inherit environment;
          inherit permissions;
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

      ".github/workflows/flake-check.yml" = {
        inherit on;
        jobs.checking-flake = {
          runs-on = "ubuntu-latest";
          inherit permissions;
          inherit environment;
          steps =
            common-actions
            ++ [
              {
                name = "Run nix flake check";
                run = "nix -vL flake check --impure --all-systems --no-build";
              }
            ];
        };
      };
    };
  };
}