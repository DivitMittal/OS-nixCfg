{ pkgs, ... } :

{
  imports = [
    ./../common
    ./ssh.nix
  ];

  terminal = {
    colors = {
      background = "#000000";
      foreground = "#FFFFFF";
      cursor = "#FFFFFF";
    };

     font =  "${pkgs.}"
  };
}