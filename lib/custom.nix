{lib, ...}: {
  scanPaths = path:
    lib.lists.map (f: (path + "/${f}")) (
      lib.attrsets.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
            (_type == "directory") || ((path != "default.nix") && (lib.strings.hasSuffix ".nix" path))
        ) (builtins.readDir path)
      )
    );
}
