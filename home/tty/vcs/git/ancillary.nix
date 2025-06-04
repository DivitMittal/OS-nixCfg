{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      transcrypt
      ;
    ghfetch = pkgs.writeShellScriptBin "ghfetch" ''
      ${pkgs.ghfetch}/bin/ghfetch --color magenta --access-token=$(cat ${config.age.secrets.github.path}) --user ${config.hostSpec.handle}
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
        gh-copilot
        gh-screensaver
        gh-markdown-preview
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
        paging = {
          useConfig = false;
          colorArg = "always";
          pager = "${pkgs.delta}/bin/delta --dark --paging=never";
        };
      };

      # What to do when opening Lazygit outside of a git repo.
      # - 'prompt': (default) ask whether to initialize a new repo or open in the most recent repo
      # - 'create': initialize a new repo
      # - 'skip': open most recent repo
      # - 'quit': exit Lazygit
      notARepository = "skip";

      update.method = "never";

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
    };
  };
}