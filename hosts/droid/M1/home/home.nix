{self, ...}: {
  imports = [
    (self + "/common/all")
    (self + "/common/home")
    (self + "/home/tty")
  ];

  # home.file."storage" = config.lib.file.mkOutOfStoreSymlink "/storage/emulated/0"; # impure
}
