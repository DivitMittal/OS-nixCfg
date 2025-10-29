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
    inherit
      (pkgs)
      sc-im
      tabiew
      doxx
      pandoc
      ;
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
    markitdown = pkgs.writeScriptBin "markitdown" ''
      exec ${pkgs.uv}/bin/uv tool run markitdown "$@"
    '';
    rich-cli = pkgs.writeScriptBin "rich" ''
      exec ${pkgs.uv}/bin/uv tool run --from rich-cli rich "$@"
    '';
  };
}
