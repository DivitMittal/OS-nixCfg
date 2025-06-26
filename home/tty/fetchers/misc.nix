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
      cpufetch
      ;
    ghfetch = pkgs.writeShellScriptBin "ghfetch" ''
      ${pkgs.ghfetch}/bin/ghfetch --color magenta --access-token=$(cat ${config.age.secrets.github.path}) --user ${config.hostSpec.handle}
    '';
  };
}