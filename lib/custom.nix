{lib, ...}: {
  # Scans a directory and returns a list of paths to all Nix modules (directories or .nix files)
  # excluding the default.nix file in the scanned directory itself.
  #
  # Performance note: This function calls builtins.readDir which is evaluated at parse time.
  # The results are effectively memoized per unique path by Nix's evaluation caching,
  # so multiple calls with the same path don't re-read the directory.
  #
  # Returns: List of absolute paths like [ /path/to/dir/module1.nix /path/to/dir/subdir ]
  scanPaths = path: let
    entries = builtins.readDir path;
    filteredEntries =
      lib.attrsets.filterAttrs (
        name: type:
          (type == "directory") || ((name != "default.nix") && (lib.strings.hasSuffix ".nix" name))
      )
      entries;
  in
    lib.lists.map (name: path + "/${name}") (lib.attrsets.attrNames filteredEntries);
}
