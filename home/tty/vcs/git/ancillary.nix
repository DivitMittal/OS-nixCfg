{
  pkgs,
  config,
  lib,
  hostPlatform,
  ...
}: let
  clipboardCmd =
    if hostPlatform.isDarwin
    then "pbcopy"
    else if hostPlatform.isLinux
    then "${pkgs.wl-clipboard}/bin/wl-copy"
    else "cat >/dev/null";
in {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      transcrypt
      ;

    gen-gitignore = pkgs.writeShellScriptBin "gen-gitignore" ''
      if [ $# -eq 0 ]; then
        echo "Usage: gen-gitignore <template1> [template2] ..." >&2
        echo "Example: gen-gitignore python node vim" >&2
        exit 1
      fi

      # Join arguments with commas for gitignore.io API
      templates=$(IFS=,; echo "$*")
      ${pkgs.curl}/bin/curl -sL "https://www.gitignore.io/api/$templates"
    '';
  };

  programs.gh = {
    enable = true;
    package = pkgs.gh;
    extensions = lib.attrsets.attrValues {
      inherit
        (pkgs)
        ## Manage
        gh-f
        gh-notify
        gh-dash
        ## Contribution
        gh-eco
        gh-skyline
        gh-contribs # gh-cal
        ## Misc
        github-copilot-cli
        gh-screensaver
        gh-markdown-preview
        gh-actions-cache
        ;
    };

    gitCredentialHelper = {
      enable = true;
      hosts = ["https://github.com" "https://gist.github.com"];
    };
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      pager = "${config.home.sessionVariables.PAGER}";
      editor = "${config.home.sessionVariables.EDITOR}";
      aliases = {
        co = "pr checkout";
      };
    };
  };

  home.shellAliases.lg = "${pkgs.lazygit}/bin/lazygit";
  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;

    settings = {
      gui = {
        mouseEvents = true;

        border = "rounded";
        animateExplosion = true;

        nerdFontsVersion = "3";
        showFileIcons = true;

        showFileTree = true;
        showRandomTip = true;
        showBottomLine = true;
      };

      git = {
        autoFetch = true;
        fetchAll = true;
        autoRefresh = true;
        parseEmoji = true;
        pagers = [
          {
            colorArg = "always";
            pager = "${pkgs.delta}/bin/delta --paging=never";
          }
        ];
      };

      # What to do when opening Lazygit outside of a git repo.
      # - 'prompt': (default) ask whether to initialize a new repo or open in the most recent repo
      # - 'create': initialize a new repo
      # - 'skip': open most recent repo
      # - 'quit': exit Lazygit
      notARepository = "skip";

      update.method = "never";

      os = {
        shell = "${pkgs.bash}/bin/bash";
        shellArg = "-c";
      };

      keybinding = {
        universal = {
          prevItem = "<up>";
          nextItem = "<down>";
          prevItem-alt = "";
          nextItem-alt = "";

          scrollLeft = "<left>";
          scrollRight = "<right>";

          gotoTop = "g";
          gotoBottom = "G";

          prevBlock = "";
          nextBlock = "";
          prevBlock-alt = "";
          nextBlock-alt = "";
          nextBlock-alt2 = "<tab>";
          prevBlock-alt2 = "<backtab>";

          scrollUpMain = "";
          scrollDownMain = "";
          scrollUpMain-alt1 = "U";
          scrollDownMain-alt1 = "E";
          scrollUpMain-alt2 = "";
          scrollDownMain-alt2 = "";

          executeShellCommand = "!";
        };
      };

      customCommands = [
        {
          key = "<c-l>";
          context = "files";
          command = ''bash -c "lumen draft | tee >(${clipboardCmd})"'';
          loadingText = "Generating message...";
          output = "popup";
        }
        {
          key = "<c-k>";
          context = "files";
          command = ''bash -c "lumen draft -c {{.Form.Context | quote}} | tee >(${clipboardCmd})"'';
          loadingText = "Generating message...";
          output = "popup";
          prompts = [
            {
              type = "input";
              title = "Context";
              key = "Context";
            }
          ];
        }
      ];
    };
  };
}
