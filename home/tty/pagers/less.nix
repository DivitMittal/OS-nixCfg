{pkgs, ...}: {
  home.sessionVariables.PAGER = "${pkgs.less}/bin/less";

  programs.less = {
    enable = true;

    keys = ''
      #command
      # scroll a page down
      # Spacebar (40 in octal)
      \40         forw-screen-force
      # PageDown
      \kD         forw-screen-force

      #env
      LESS=--RAW-CONTROL-CHARS --mouse -C --tilde --tabs=2 -W --status-column -i
      LESSHISTFILE=-
      LESSCOLORIZER=bat
    '';
  };

  programs.lesspipe.enable = true;
}
