{ self, ... }:

{
  imports = [
    (self + /home/common)
    (self + /home/tty-env)
  ];
}