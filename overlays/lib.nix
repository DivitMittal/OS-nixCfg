{lib, ...}: {
  default = self: super: {
    custom = builtins.import ../lib {inherit lib;};
  };
}
