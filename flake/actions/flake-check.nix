{
  common-on,
  common-permissions,
  common-actions,
  environment,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/flake-check.yml" = {
    on = common-on;
    jobs.checking-flake = {
      runs-on = "ubuntu-latest";
      permissions = common-permissions;
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
}
