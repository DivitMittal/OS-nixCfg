{
  pkgs,
  lib,
  ...
}: {
  programs.visidata = {
    enable = true;
    package = pkgs.visidata;
  };

  home.packages = lib.attrsets.attrValues {
    inherit (pkgs) sc-im;
    ## Euporie (Jupyter client)
    euporie-notebook = pkgs.writeScriptBin "euporie-notebook" ''
      exec ${pkgs.uv}/bin/uv tool run --from euporie euporie-notebook "$@"
    '';
    euporie-preview = pkgs.writeScriptBin "euporie-preview" ''
      exec ${pkgs.uv}/bin/uv tool run --from euporie euporie-preview "$@"
    '';
    euporie = pkgs.writeScriptBin "euporie" ''
      exec ${pkgs.uv}/bin/uv tool run --from euporie euporie "$@"
    '';
  };
}
