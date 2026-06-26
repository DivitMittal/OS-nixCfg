{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.OS-nixCfg-secrets.homeManagerConfigurations.himalayaAccounts
  ];

  programs.himalaya = {
    enable = true;
    package = pkgs.himalaya.override {buildFeatures = ["oauth2"];};
  };
}
