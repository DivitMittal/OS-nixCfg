{ config, lib, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./nixpkgs.nix
  ];

  home = {
    preferXdgDirectories  = lib.mkDefault true;
    extraOutputsToInstall = ["doc" "info" "devdoc"];
    stateVersion          = lib.mkDefault "23.11";
  };

  home.packages = builtins.attrValues {
    my-hello  = pkgs.writeShellScriptBin "my-hello" ''echo "Hello, ${config.home.username}!"'';
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  editorconfig = {
   enable = lib.mkDefault true;
   # top-most editorconfig
   settings = {
    "*" = {
      charset = "utf-8";
      end_of_line = "lf";
      trim_trailing_whitespace = true;
      insert_final_newline = lib.mkDefault false;
      max_line_width = 200;
      indent_style = "space";
      indent_size = lib.mkDefault 2;
      spelling_language = "en-US";
    };
   };
  };
}