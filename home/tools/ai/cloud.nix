{
  lib,
  pkgs,
  config,
  ...
}: {
  home.sessionVariables = {
    KAGGLE_CONFIG_DIR = "${config.xdg.configHome}/kaggle";
    HF_HUB_DISABLE_TELEMETRY = "1";
  };
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      kaggle
      ;
    hf = pkgs.writeShellScriptBin "hf" ''
      exec ${pkgs.uv}/bin/uv tool run --from huggingface-hub[cli] hf "$@"
    '';
  };
}
