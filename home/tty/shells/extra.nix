{pkgs, ...}: {
  # home.packages = lib.attrsets.attrValues {
  #   inherit(pkgs)
  #      powershell
  #   ;
  # };

  programs.nushell = {
    enable = false;
    package = pkgs.nushell;

    configFile.text = ''
      $env.config = {
        show_banner: false,
      }
    '';
  };
}
