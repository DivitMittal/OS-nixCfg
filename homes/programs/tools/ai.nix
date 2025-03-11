{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit(pkgs)
     aichat
    ;
  };

  # programs.mods = {
  #   enable = true;
  #   package = pkgs.mods;
  #   enableBashIntegration = false; enableFishIntegration = true; enableZshIntegration = true;
  #   settings = {
  #     default-model = "";
  #     roles = {
  #       shell = [
  #         "you are a shell expert"
  #         "you don't explain anything"
  #         "you simply output one liners to solve the problems you're asked"
  #         "you don't provide any explanation whatsoever, only the command"
  #       ];
  #     };
  #     apis = {
  #       copilot = {
  #         base-url = "https://api.githubcopilot.com/";
  #         models = {
  #           "claude-3.7-sonnet" = {
  #             aliases = [ "claude3.7" ];
  #             max-input-chars = 68000;
  #           };
  #           "" = {
  #             aliases = [];
  #             max-input-chars = 65464;
  #           };
  #         };
  #       };
  #     },
  #   };
  # };
}