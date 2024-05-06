_:

{
  programs.git = {
    enable = true;

    userName   = "Divit Mittal";
    userEmail  = "64.69.76.69.74.m@gmail.com";

    attributes = import ./attributes.nix;
    ignores    = import ./ignore.nix;

    aliases = {
      last       = "log -1 HEAD";
      graph      = "log --graph --all --full-history --pretty=format:'%Cred%h%Creset %ad %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short";
      unstage    = "restore --staged";
      clean-U-dr = "clean -d -x f -n";
      clean-U    = "clean -d -x -f";
    };

    delta = {
      enable = true;

      options = {

        features = "decorations";

        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };

        whitespace-error-style = "22 reverse";
      };
    };

    extraConfig = {
      core = {
        editor       = "nvim";
        autocrlf     = "input";
        ignorecase   = false;
        excludesfile = "~/.config/git/ignore";
      };

      push = { default       = "simple"; followTags    = true; };

      init  = { defaultBranch = "master"; };

      fetch = { prune         = true; };

      grep  = { lineNumber    = true; };

      help  = { autocorrect   = "1"; };

      merge = { conflictstyle = "diff3"; };

      color = { ui = "auto"; };
    };
  };
}