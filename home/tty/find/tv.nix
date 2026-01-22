{pkgs, ...}: {
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
          description = "Search and preview npm registry packages";
          requirements = ["curl" "jq"];
        };
        source.command = "for i in 0 250 500 750 1000 1250 1500 1750 2000; do curl -s \"https://registry.npmjs.org/-/v1/search?size=250&from=$i&popularity=1.0\"; done | jq -rs '[.[]?.objects[]?.package.name // empty] | unique | .[]' | sort";
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
          description = "Search and preview PyPI packages";
          requirements = ["curl" "jq"];
        };
        source.command = "curl -s 'https://hugovk.github.io/top-pypi-packages/top-pypi-packages-30-days.min.json' | jq -r '.rows[].project' | head -500";
        preview = {
          command = ''
            curl -s "https://pypi.org/pypi/{0}/json" | jq -r '"\u001b[1;36m# \(.info.name):\(.info.version)\u001b[0m\n\(.info.summary // "")\n\n\u001b[1mAuthor:\u001b[0m \(.info.author // "N/A")\n\u001b[1mLicense:\u001b[0m \(.info.license // "N/A")\n\u001b[1mHomepage:\u001b[0m \(.info.home_page // .info.project_url // "N/A")"'
          '';
          ansi = true;
        };
        keybindings.enter = "actions:open";
        actions.open = {
          description = "Open the selected package on PyPI";
          command = "open 'https://pypi.org/project/{0}/'";
          mode = "execute";
        };
      };
    };
  };
}
