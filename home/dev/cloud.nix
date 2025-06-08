{
  lib,
  pkgs,
  ...
}: {
  programs.awscli = {
    enable = false;
    package = pkgs.awscli2;

    settings = {
      "default" = {
        region = "ap-south-1";
        output = "json";
      };
    };
  };

  home.packages = lib.attrsets.attrValues {
    ## cloud-platforms-cli
    #gcp = pkgs.google-cloud-sdk;
  };
}
