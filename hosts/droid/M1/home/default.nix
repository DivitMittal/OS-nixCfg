{ self, config, ... }:

{
  imports = [
    (self + /home/common)
    (self + /home/tty-env)
  ];

  home.file."storage" = config.lib.file.mkOutOfStoreSymlink /storage/emulated/0; # impure
}