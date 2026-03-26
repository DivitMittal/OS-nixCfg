{pkgs, ...}: {
  home.sessionVariables.PAGER = "${pkgs.less}/bin/less";
}
