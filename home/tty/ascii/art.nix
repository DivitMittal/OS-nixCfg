{
  pkgs,
  lib,
  ...
}: {
  home.packages =
    lib.attrsets.attrValues {
      inherit
        (pkgs)
        lolcat
        clock-rs
        ;
      figlet = pkgs.python313Packages.pyfiglet;
    }
    ++ [
      # Rainbow banner: Create colorful ASCII art text
      (pkgs.writeShellScriptBin "rainbow-banner" ''
        if [ $# -eq 0 ]; then
          echo "Usage: rainbow-banner <text>"
          echo "Creates colorful ASCII art from text"
          exit 1
        fi
        ${pkgs.python313Packages.pyfiglet}/bin/pyfiglet "$*" | ${pkgs.lolcat}/bin/lolcat
      '')
    ];
}
