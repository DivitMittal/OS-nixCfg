{
  lib,
  inputs,
  ...
}: {
  nix = {
    registry = lib.attrsets.mapAttrs (_: value: {flake = value;}) inputs; # add each flake input as a registry

    settings = {
      #nixPath = lib.attrsets.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry; # add flake inputs to the $NIX_PATH

      substituters = [
        "https://cache.nixos.org"
        "https://wezterm.cachix.org"
        "https://yazi.cachix.org"
        "https://om.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
      ];
    };

    gc = {
      automatic = true;
      frequency = "daily";
      options = "--delete-old";
    };
  };
}