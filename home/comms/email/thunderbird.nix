{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.OS-nixCfg-secrets.homeManagerConfigurations.tbAccounts
  ];

  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird;

    profiles."main" = {
      isDefault = true;
      accountsOrder = [
        "1mitDivG"
        "2divibG"
        "3devDivG"
        "4finDivZ"
        "5forDivG"
        "divQeztaG"
        "dpsDivG"
        "divShare"
        "divA"
        "divO"
        "divMuj"
        "vanG"
        "6aSwiptG"
        "7aCiazG"
        "spG"
        "lmG"
      ];
    };
  };
}
