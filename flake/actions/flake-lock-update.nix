{
  common-permissions,
  common-actions,
  environment,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/flake-lock-update.yml" = {
    on = {
      workflow_dispatch = {};
      schedule = [
        {
          cron = "0 0 * * 0"; # Every Sunday at midnight
        }
      ];
    };
    jobs.locking-flake = {
      runs-on = "ubuntu-latest";
      permissions =
        common-permissions
        // {
          issues = "write";
          pull-requests = "write";
        };
      inherit environment;
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