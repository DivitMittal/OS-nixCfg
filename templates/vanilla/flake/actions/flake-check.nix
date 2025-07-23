{
  common-on,
  common-permissions,
  common-actions,
  ...
}: {
  flake.actions-nix.workflows.".github/workflows/flake-check.yml" = {
    on = common-on;
    jobs.checking-flake = {
      permissions = common-permissions;
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
