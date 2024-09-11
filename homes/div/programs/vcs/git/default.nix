{ pkgs, config, ... }:

{
  programs.fish.shellAbbrs = {
    gs  = { expansion = "git status"; position = "command";};
    gph = { expansion = "git push"; position = "command";};
    gpl = { expansion = "git pull"; position = "command";};
    gf  = { expansion = "git fetch"; position = "command";};
    gc  = { expansion = "git commit -m \"\""; position = "command";};
    ga  = { expansion = "git add"; position = "command";};
  };

  programs.zsh.zsh-abbr.abbreviations = {
    gs  = "git status";
    gph = "git push";
    gpl = "git pull";
    gf  = "git fetch";
    gc  = "git commit -m \"\"";
    ga  = "git add";
  };

  programs.gh = {
    enable = true;
    package = pkgs.gh;
    extensions = with pkgs; [ gh-eco gh-dash ];

    gitCredentialHelper = {
      enable = true;
      hosts = [ "https://github.com" "https://gist.github.com" ];
    };
    settings = {
      git_protocol= "ssh";
      prompt= "enabled";  # interactivity in gh
      pager= "less";
      aliases = {
        co = "pr checkout";
      };
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName   = "DivitMittal";
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
      package = pkgs.delta;

      options = {
        features = "custom-delta";
        custom-delta = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
          paging = "always";
        };

        whitespace-error-style = "22 reverse";
      };
    };

    extraConfig = {
      core = {
        autocrlf     = "input";
        ignorecase   = false;
        editor       = "${config.home.sessionVariables.VISUAL}";
        excludesfile = "${config.xdg.configHome}/git/ignore";
      };

      push = {
        default = "simple";
        followTags = true;
      };
      init = {
        defaultBranch = "main";
      };
      fetch = {
        prune = true;
      };
      grep = {
        lineNumber = true;
      };
      help = {
        autocorrect = "1";
      };
      merge = {
        conflictstyle = "diff3";
      };
      color = {
        ui = "auto";
      };
    };
  };
}