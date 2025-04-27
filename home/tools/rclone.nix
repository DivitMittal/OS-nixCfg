{
  pkgs,
  config,
  ...
}: let
  common = ''
    # Log start time
    echo "Script started at $(date)"

    # Check if rclone is installed
    if ! command -v rclone &> /dev/null; then
      echo "rclone could not be found. Please install it."
      exit 1
    fi

    # Check if the remote specified exists
    if ! rclone lsd OneDrive-Divit: &> /dev/null; then
      echo "The specified remote 'OneDrive-Divit' does not exist or is not accessible."
      mkdir -p ~/Remotes/OneDrive-Divit
      exit 1
    fi

    # Check if there is any connectivity
    if ! ping -c 1 8.8.8.8 &> /dev/null; then
      echo "No network connectivity."
      exit 1
    fi

    # Function to handle cleanup
    cleanup() {
      echo "Cleaning up and exiting..."
      kill $RCLONE_PID
      exit 0
    }

    # Trap SIGINT and SIGTERM
    trap cleanup SIGINT SIGTERM

    # Fine-tune options as needed, but here's the gist of what we're passing
    # Note that I set these option values because I'm a write-heavy user.
    # --vfs-cache-mode full
    # This enables full caching of files, which is beneficial for frequently accessed and modified files like markdown and docx documents.
    # --vfs-cache-max-age 24h
    # Keeps cached files for 24 hours, allowing quick access to recently modified documents.
    # --dir-cache-time 5m
    # Reduces directory caching time to 5 minutes, ensuring you see updated directory listings more frequently.
    # --poll-interval 1m
    # Checks for remote changes every minute, useful for syncing modifications quickly.
    # --vfs-read-chunk-size 1M
    # Sets a smaller read chunk size, which can be more efficient for smaller text-based files.
    # --buffer-size 32M
    # Increases the buffer size to improve performance when reading/writing files.
    # --vfs-read-ahead 128M
    # Enables read-ahead caching to improve performance when reading files sequentially.
    # --vfs-write-back 5s
    # Reduces write-back time to 5 seconds, ensuring modifications are synced to the remote more quickly.
    # --attr-timeout 1s
    # Reduces attribute caching time, ensuring you see the latest file attributes more frequently.
    # --no-modtime
    # Disables modification time checks, which can speed up operations on frequently modified files.
    rclone mount \
      --vfs-cache-max-size 50G \
      --vfs-cache-max-age 48h \
      --dir-cache-time 5m \
      --poll-interval 1m \
      --vfs-read-chunk-size 1M \
      --buffer-size 32M \
      --vfs-read-ahead 128M \
      --vfs-write-back 1m \
      --attr-timeout 1s \
      --no-modtime \
      --vfs-cache-mode full \
      --log-level ERROR \
      --no-unicode-normalization=false'';
  remotesPath = "${config.home.homeDirectory}/Remotes";
in {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      rclone
      ;

    # fuse =
    #   if hostPlatform.isDarwin
    #   then pkgs.brewCasks.fuse-t
    #   else null;

    OneDrive-Divit = pkgs.writeShellScriptBin "OneDrive-Divit" ''
      ${common} OneDrive-Divit: ${remotesPath}/OneDrive-Divit
    '';

    OneDrive-MUJ = pkgs.writeShellScriptBin "OneDrive-MUJ" ''
      ${common} OneDrive-MUJ: ${remotesPath}/OneDrive-MUJ
    '';

    GoogleDrive-Divit = pkgs.writeShellScriptBin "GoogleDrive-Divit" ''
      ${common} GoogleDrive-Divit: ${remotesPath}/GoogleDrive-Divit
    '';

    GooglePhotos-Divit = pkgs.writeShellScriptBin "GooglePhotos-Divit" ''
      ${common} GooglePhotos-Divit: ${remotesPath}/GooglePhotos-Divit
    '';
  };
}
