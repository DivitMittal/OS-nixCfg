{inputs, ...}: {
  imports = [inputs.actions-nix.flakeModules.default];

  flake.actions-nix = {
    pre-commit.enable = true;
    defaults = {
      jobs = {
        runs-on = "macos-latest";
        timeout-minutes = 30;
        environent.name = "dev";
        permissions.contents = "write";
      };
    };

    workflows = {
      ".github/workflows/darwin-build.yml" = {
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

        jobs = {
          build-L1-job = {
            name = "Builds a nix-darwin configuration";
            steps = [
              {
                name = "Checkout repo";
                uses = "actions/checkout@main";
                "with" = {
                  "fetch-depth" = 1;
                };
              }
              {
                name = "Set env var";
                run = "echo \"OS_NIXCFG=$(pwd)\" >> \"$GITHUB_ENV\"";
              }
              {
                name = "Installing Nix";
                uses = "DeterminateSystems/nix-installer-action@main";
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
              {
                name = "Build nix-darwin configuration";
                run = "nix build --accept-flake-config .#darwinConfigurations.L1.config.system.build.toplevel --impure --show-trace";
              }
            ];
          };
        };
      };
    };
  };
}