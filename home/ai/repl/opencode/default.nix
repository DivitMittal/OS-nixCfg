{
  pkgs,
  lib,
  ...
}: let
  ohMyOpencodeConfig = {
    "$schema" = "https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/master/assets/oh-my-opencode.schema.json";
    google_auth = false;
    agents = {
      oracle = {
        model = "github/claude-opus-4-5";
      };
      frontend-ui-ux-engineer = {
        model = "google/gemini-3-pro-high";
      };
      document-writer = {
        model = "google/gemini-3-flash";
      };
      multimodal-looker = {
        model = "google/gemini-2.5-flash";
      };
    };
  };
in {
  imports = lib.custom.scanPaths ./.;

  programs.opencode = {
    enable = true;
    package = pkgs.writeShellScriptBin "opencode" ''
      exec ${pkgs.pnpm}/bin/pnpm dlx opencode-ai "$@"
    '';
    # package = pkgs.ai.opencode;
    enableMcpIntegration = false;

    settings = {
      autoupdate = false;
      autoshare = false;
      theme = "system";

      plugin = [
        "oh-my-opencode"
        "opencode-antigravity-auth@1.1.2"
      ];
    };
  };

  ## oh-my-opencode
  xdg.configFile."opencode/oh-my-opencode.json".text = builtins.toJSON ohMyOpencodeConfig;
}
