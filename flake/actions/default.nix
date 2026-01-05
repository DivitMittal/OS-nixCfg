{
  inputs,
  lib,
  ...
}: {
  imports =
    (lib.custom.scanPaths ./.)
    ++ [
      inputs.actions-nix.flakeModules.default
    ];

  _module.args = rec {
    common-on = rec {
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
    common-permissions = {
      contents = "write";
      id-token = "write";
    };
    common-post-actions = [
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
    common-actions =
      [
        {
          name = "Checkout repo";
          uses = "actions/checkout@main";
          "with" = {
            fetch-depth = 1;
            persist-credentials = false;
          };
        }
      ]
      ++ common-post-actions;
    common-actions-cred =
      [
        {
          name = "Checkout repo";
          uses = "actions/checkout@main";
          "with" = {
            fetch-depth = 1;
            persist-credentials = true;
          };
        }
      ]
      ++ common-post-actions;
  };

  flake.actions-nix = {
    pre-commit.enable = true;
    defaultValues = {
      jobs = {
        runs-on = "ubuntu-latest";
        timeout-minutes = 90;
      };
    };
  };
}
