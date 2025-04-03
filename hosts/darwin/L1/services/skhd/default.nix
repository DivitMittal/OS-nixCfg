{pkgs, ...}: {
  environment.systemPackages = with pkgs; [jq];

  services.skhd = {
    enable = true;
    package = pkgs.skhd;

    skhdConfig = builtins.readFile ./skhdrc;
  };
}
