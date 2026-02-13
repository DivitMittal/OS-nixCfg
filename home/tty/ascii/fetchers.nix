{
  pkgs,
  lib,
  config,
  inputs,
  hostPlatform,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit (pkgs) ipfetch;
    inherit (inputs.nixpkgs-2505.legacyPackages.${hostPlatform.system}) cpufetch;
    ghfetch = pkgs.writeShellScriptBin "ghfetch" ''
      ${pkgs.ghfetch}/bin/ghfetch --color magenta --access-token=$(cat ${config.age.secrets."api/github.txt".path}) --user ${config.hostSpec.handle}
    '';
  };
}
