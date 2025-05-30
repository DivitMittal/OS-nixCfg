{
  pkgs,
  config,
  ...
}: {
  imports = [./ancillary.nix];

  home.sessionVariables.GIT_HOSTING = "git@github.com:${config.programs.git.userName}";

  programs.fish.shellAbbrs = {
    gs = {
      expansion = "git status";
      position = "command";
    };
    gph = {
      expansion = "git push";
      position = "command";
    };
    gpl = {
      expansion = "git pull";
      position = "command";
    };
    gf = {
      expansion = "git fetch";
      position = "command";
    };
    gc = {
      expansion = "git commit -m \"\"";
      position = "command";
    };
    ga = {
      expansion = "git add";
      position = "command";
    };
  };

  programs.zsh.zsh-abbr.abbreviations = {
    gs = "git status";
    gph = "git push";
    gpl = "git pull";
    gf = "git fetch";
    gc = "git commit -m \"\"";
    ga = "git add";
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = config.hostSpec.userFullName;
    userEmail = config.hostSpec.email.dev;

    attributes = builtins.import ./attributes.nix;
    ignores = builtins.import ./../common/ignore.nix;

    aliases = {
      last = "log -1 HEAD";
      graph = "log --graph --all --full-history --pretty=format:'%Cred%h%Creset %ad %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short";
      unstage = "restore --staged";
      clean-U-dr = "clean -d -x f -n";
      clean-U = "clean -d -x -f";
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
        autocrlf = "false";
        eol = "lf";
        ignorecase = true;
        filemode = false;
        editor = "${config.home.sessionVariables.VISUAL}";
        excludesfile = "${config.xdg.configHome}/git/ignore";
        symlinks = true;
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