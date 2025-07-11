{
  lib,
  inputs,
  config,
  ...
}: {
  nix = {
    registry = lib.attrsets.mapAttrs (_: value: {flake = value;}) inputs; # add each flake input as a registry
    #nixPath = lib.attrsets.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry; # add flake inputs to the $NIX_PATH

    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://wezterm.cachix.org"
        "https://yazi.cachix.org"
        "https://pre-commit-hooks.cachix.org"
        "https://numtide.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };

    gc = {
      automatic = true;
      frequency = "daily";
      options = "--delete-old";
    };

    extraOptions = ''
      !include ${config.age.secrets."nix.conf".path}
    '';
  };
}
