{
  lib,
  inputs,
  config,
  hostPlatform,
  ...
}: {
  nix = {
    registry = lib.attrsets.mapAttrs (_: value: {flake = value;}) inputs; # add each flake input as a registry
    nixPath = lib.attrsets.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry; # add flake inputs to the $NIX_PATH

    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://pre-commit-hooks.cachix.org"
        "https://numtide.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };

    gc = {
      automatic = true;
      dates =
        if hostPlatform.isDarwin
        then "weekly"
        else "Sun 22:00";
      options = "--delete-old";
    };

    extraOptions = ''
      !include ${config.age.secrets."nix.conf".path}
    '';
  };
}
