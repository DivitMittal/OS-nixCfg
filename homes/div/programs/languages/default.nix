{ pkgs, ... }:

{
  imports = [
    ./javascript
    ./python
  ];

  home.packages = with pkgs; [ jdk ];
}