{ config, pkgs, ... }:
let
  pythonPackages = with pkgs; [ pipx micromamba ];
in
{
  config = {
    home.packages = pythonPackages;
  };
}