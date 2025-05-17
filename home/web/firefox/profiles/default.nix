{
  pkgs,
  config,
  lib,
  hostPlatform,
  inputs,
  ...
}: let
  profilesDir = "${config.programs.firefox.configPath}" + lib.strings.optionalString hostPlatform.isDarwin "/Profiles";
  currentProfileDir = "${profilesDir}/custom-default";
  profiles = {
    clean-profile = {
      id = 0;
      isDefault = false;
    };

    custom-default = {
      id = 1;
      isDefault = true;

      bookmarks = {
        force = true;
        settings = [];
      };

      # containers = {
      #   second = {
      #     color = "blue";
      #     icon = "tree";
      #     id = 1;
      #   };
      #   finance = {;
      #     color = "green";
      #     icon = "dollar";
      #     id = 2;
      #   };
      # };
      # containersForce = true;

      search = {
        force = true;
        default = "Unduck";
        privateDefault = "Unduck";

        engines = {
          "bing".metaData.hidden = true;
          # built-in engines only support specifying one additional alias
          "google".metaData.alias = "@g";
          "wikipedia".metaData.alias = "@w";
          "ddg".metaData.alias = "@d";

          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          "Youtube" = {
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@yt"];
          };

          "Github" = {
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                  {
                    name = "type";
                    value = "repositories";
                  }
                ];
              }
            ];
            definedAliases = ["@gh"];
          };

          "Startpage" = {
            urls = [
              {
                template = "https://www.startpage.com/sp/search";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@sp"];
          };

          "Unduck" = {
            urls = [
              {
                template = "https://unduck.link";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@ud"];
          };

          "Perplexity" = {
            urls = [
              {
                template = "https://www.perplexity.ai";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@p"];
          };

          "Searchix" = {
            urls = [
              {
                template = "https://searchix.alanpearce.eu";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@sx"];
          };
        };
      };

      # settings = import ./user_settings.nix;
      betterfox = {
        enable = true;
        enableAllSections = true;
      };
      userContent = lib.strings.readFile ./chrome/userContent.css;
      userChrome = lib.strings.readFile ./chrome/userChrome.css;
    };
  };
in {
  _module.args = {
    inherit currentProfileDir;
  };
  imports = [
    inputs.betterfox.homeManagerModules.betterfox
    ./chrome
  ];
  programs.firefox.profiles = profiles;
  programs.firefox.betterfox.enable = true;
}
