{
  pkgs,
  config,
  lib,
  hostPlatform,
  inputs,
  fx-autoconfig,
  ...
}: let
  fx-csshacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "016521f0a21bbb76e8eff4b8410c1e049f081c77";
    hash = "sha256-dUboMxvWSP1PS9NT8PsmfOMF1HKqvH6jUAT1La5k6wM=";
  };
  profileDir = "${config.programs.firefox.configPath}" + lib.optionalString hostPlatform.isDarwin "/Profiles";
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
        };
      };

      # settings = import ./user_settings.nix;
      betterfox = {
        enable = true;
        enableAllSections = true;
      };
      userContent = builtins.readFile ./chrome/userContent.css;
      userChrome = builtins.readFile ./chrome/userChrome.css;
    };
  };
in {
  imports = [
    inputs.betterfox.homeManagerModules.betterfox
  ];
  programs.firefox.profiles = profiles;
  programs.firefox.betterfox.enable = true;

  ## fx-csshacks
  home.file."${profileDir}/custom-default/chrome/CSS/fx-csshacks" = {
    source = fx-csshacks;
    recursive = true;
  };

  ## fx-autoconfig
  home.file."${profileDir}/custom-default/chrome/JS" = {
    source = ./chrome/JS;
    recursive = true;
  };
  home.file."${profileDir}/custom-default/chrome/resources" = {
    source = fx-autoconfig + "/profile/chrome/resources";
    recursive = true;
  };
  home.file."${profileDir}/custom-default/chrome/utils" = {
    source = fx-autoconfig + "/profile/chrome/utils";
    recursive = true;
  };
}