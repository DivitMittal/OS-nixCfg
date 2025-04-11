_: {
  # programs.awscli = {
  #   enable = true;
  #   package = pkgs.awscli2;
  #
  #   settings = {
  #     "default" = {
  #       region = "ap-south-1";
  #       output = "json";
  #     };
  #   };
  # };

  home.packages = builtins.attrValues {
    ## cloud-platforms-cli
    #gcp = pkgs.google-cloud-sdk;
  };
}
