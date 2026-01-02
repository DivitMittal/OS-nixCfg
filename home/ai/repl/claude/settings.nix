{pkgs, ...}: {
  programs.claude-code.settings = {
    includeCoAuthoredBy = false;
    statusLine = {
      command = "${pkgs.ai.ccstatusline}/bin/ccstatusline";
      padding = 0;
      type = "command";
    };
    theme = "dark";
  };
}
