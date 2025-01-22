{ pkgs, ... }:

{
  programs.awscli = {
    enable = true;
    package = pkgs.awscli2;

    settings = {
      "default" = {
        region = "ap-south-1";
        output = "json";
      };
    };
  };

  home.packages = with pkgs; [
    # cloud-platforms-cli
    google-cloud-sdk
  ];
}