{
  pkgs,
  lib,
  config,
  hostPlatform,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ## Android
      android-tools
      scrcpy
      ## Programming Languages
      #tree-sitter
      ## java
      #jdk gradle
      ## lua
      lua
      # Rust
      cargo
      ## IDE
      #vscode
      #rstudio
      ;

    vscode =
      if hostPlatform.isDarwin
      then pkgs.brewCasks.visual-studio-code
      else pkgs.vscode;
    #luarocks = pkgs.luajitPackages.luarocks;
  };

  home.sessionPath = lib.mkAfter ["${config.home.homeDirectory}/.cargo/bin"];
}
