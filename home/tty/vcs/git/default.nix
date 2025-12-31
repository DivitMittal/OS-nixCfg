{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = [./ancillary.nix];

  home.sessionVariables.GIT_HOSTING = mkIf config.programs.git.enable "git@github.com:${config.programs.git.settings.user.name}";

  programs.fish.shellAbbrs = mkIf (config.programs.fish.enable && config.programs.git.enable) {
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

  programs.zsh.zsh-abbr.abbreviations = mkIf (config.programs.zsh.enable && config.programs.git.enable) {
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
    lfs.enable = true;

    settings = {
      user = {
        name = config.hostSpec.userFullName;
        email = config.hostSpec.email.dev;
      };
      aliases = {
        last = "log -1 HEAD";
        graph = "log --graph --all --full-history --pretty=format:'%Cred%h%Creset %ad %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short";
        unstage = "restore --staged";
        clean-U-dr = "clean -d -x f -n";
        clean-U = "clean -d -x -f";
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
        http = {
          sslCAInfo = "/etc/ssl/certs/ca-certificates.crt";
        };
      };
    };

    attributes = import ./attributes.nix;
    ignores = import ./../common/ignore.nix;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = config.programs.git.enable;
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
}
