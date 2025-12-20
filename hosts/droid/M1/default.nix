{
  pkgs,
  inputs,
  ...
}: {
  environment.packages = [pkgs.home-manager];

  # Make home-manager use the flake's home-manager
  nix.registry.home-manager.flake = inputs.home-manager;

  user = rec {
    uid = 10660;
    gid = uid;
    shell = "${pkgs.fish}/bin/fish";
  };
}
