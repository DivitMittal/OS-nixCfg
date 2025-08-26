{pkgs, ...}: {
  home.packages = [pkgs.nur.repos.charmbracelet.crush];
  xdg.configFile."crush/crush.json".source = ./crush.json;
}
