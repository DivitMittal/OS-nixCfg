{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ipfetch
      ;
    inherit
      (pkgs.nixosStable)
      cpufetch
      ;
    ghfetch = pkgs.writeShellScriptBin "ghfetch" ''
      ${pkgs.ghfetch}/bin/ghfetch --color magenta --access-token=$(cat ${config.age.secrets."api/github.txt".path}) --user ${config.hostSpec.handle}
    '';
  };
}
