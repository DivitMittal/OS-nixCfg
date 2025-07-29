{
  common-permissions,
  common-actions,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/flake-lock-update.yml" = {
    on = {
      workflow_dispatch = {};
    };
    jobs.locking-flake = {
      permissions =
        common-permissions
        // {
          issues = "write";
          pull-requests = "write";
        };
      steps =
        common-actions
        ++ [
          {
            name = "Update flake.lock";
            uses = "DeterminateSystems/update-flake-lock@main";
          }
        ];
    };
  };
}
