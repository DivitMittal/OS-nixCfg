{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  git-pull-all = pkgs.writeShellApplication {
    name = "git-pull-all";
    runtimeInputs = with pkgs; [fd git];
    text = ''
      # Find all .git directories recursively and pull each repository
      # Usage: git-pull-all [directory]
      # If no directory is specified, uses current directory

      TARGET_DIR="''${1:-.}"

      if [ ! -d "$TARGET_DIR" ]; then
        echo "Error: Directory '$TARGET_DIR' does not exist" >&2
        exit 1
      fi

      echo "Searching for git repositories in: $TARGET_DIR"
      echo ""

      # Find all .git directories (including hidden), then get parent directory
      # -H: search hidden files/directories
      # -t d: only directories
      # -x: execute command for each result
      # shellcheck disable=SC2016
      fd -H -t d '^\.git$' "$TARGET_DIR" -x sh -c '
        repo_dir=$(dirname "{}")
        echo "================================================"
        echo "Repository: $repo_dir"
        echo "================================================"
        if git -C "$repo_dir" pull; then
          echo "✓ Successfully pulled"
        else
          echo "✗ Failed to pull (exit code: $?)" >&2
        fi
        echo ""
      '

      echo "Done!"
    '';
  };
in {
  home.packages = mkIf config.programs.git.enable [
    git-pull-all
  ];
}
