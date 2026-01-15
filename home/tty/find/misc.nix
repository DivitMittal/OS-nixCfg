{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      fselect # SQL find
      ;
  };

  programs.fd = {
    enable = true;
    package = pkgs.fd;
    hidden = true; # creates shell alias
  };

  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;

    enableFishIntegration = config.programs.fish.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = false;
    enableNushellIntegration = false;
    options = ["--cmd cd"];
  };

  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep;

    arguments = [
      "-i"
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };

  programs.ripgrep-all = {
    enable = true;
    package = pkgs.ripgrep-all;
  };

  programs.television = {
    enable = true;
    # Wrap television to use bash as default shell for shell-specific commands
    package = pkgs.symlinkJoin {
      name = "television-wrapped";
      paths = [pkgs.television];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/tv \
          --set SHELL ${pkgs.bash}/bin/bash
      '';
    };
    # Disable all shell integrations to avoid keybinding conflicts with atuin (ctrl-r) and file completion (ctrl+t)
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;

    channels = {
      brew = {
        metadata = {
          name = "brew";
          description = "Search and preview Homebrew packages";
          requirements = ["brew" "jq"];
        };
        source.command = "(brew formulae; brew casks) | sort";
        preview = {
          command = ''
            brew info --json=v2 '{0}' | jq -r '
              if (.casks | length) > 0 then
                .casks[0] | "\u001b[1;36m# \(.token):\(.version)\u001b[0m\n\(.desc // "")\n\u001b[1mType:\u001b[0m Cask\n\u001b[1mStatus:\u001b[0m \(if .installed then "Installed" else "Not installed" end)"
              else
                .formulae[0] | "\u001b[1;36m# \(.name):\(.versions.stable)\u001b[0m\n\(.desc // "")\n\u001b[1mType:\u001b[0m Formula\n\u001b[1mStatus:\u001b[0m \(if (.installed | length) > 0 then "Installed" else "Not installed" end)"
              end
            '
          '';
          ansi = true;
        };
        keybindings.enter = "actions:open";
        actions.open = {
          description = "Open the selected package's homepage";
          command = "brew home '{0}'";
          mode = "execute";
        };
      };

      npm = {
        metadata = {
          name = "npm";
          description = "Search and preview installed npm packages";
          requirements = ["npm" "jq"];
        };
        source.command = "npm list -g --depth=0 --json 2>/dev/null | jq -r '.dependencies // {} | keys[]' | sort";
        preview = {
          command = ''
            npm view '{0}' --json 2>/dev/null | jq -r '"\u001b[1;36m# \(.name):\(.version)\u001b[0m\n\(.description // "")\n\n\u001b[1mHomepage:\u001b[0m \(.homepage // "N/A")\n\u001b[1mLicense:\u001b[0m \(.license // "N/A")\n\u001b[1mKeywords:\u001b[0m \((.keywords // []) | join(", "))"'
          '';
          ansi = true;
        };
        keybindings.enter = "actions:open";
        actions.open = {
          description = "Open the selected package's homepage";
          command = "npm view '{0}' homepage | xargs open";
          mode = "execute";
        };
      };

      pip = {
        metadata = {
          name = "pip";
          description = "Search and preview installed pip packages";
          requirements = ["pip" "jq"];
        };
        source.command = "pip list --format=json 2>/dev/null | jq -r '.[].name' | sort";
        preview = {
          command = "pip show '{0}'";
          ansi = false;
        };
        keybindings.enter = "actions:open";
        actions.open = {
          description = "Open the selected package's homepage";
          command = "pip show '{0}' | grep 'Home-page:' | awk '{print $2}' | xargs open";
          mode = "execute";
        };
      };
    };
  };
}
