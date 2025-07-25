{pkgs, ...}: {
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    generateCompletions = true;

    loginShellInit = ''
      set -g fish_greeting
    '';

    interactiveShellInit = ''
      set -g fish_vi_force_cursor 1
      set -g fish_cursor_default block
      set -g fish_cursor_visual block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace_one underscore
    '';

    functions = {
      hisaab = ''
        if test (count $argv) -eq 1
          echo $argv | sed -E 's/\(([A-Za-z&])*\)//g' | bc -q
        else
          echo "Please provide a valid input"
        end
      '';
    };

    shellAliases = {
      brew-ultimate = "brew update; and brew upgrade; and brew autoremove; and brew cleanup -s --prune=0; and rm -rf (brew --cache)";
    };

    shellAbbrs = {
      ".2" = {
        expansion = "../..";
        position = "anywhere";
      };
      ".3" = {
        expansion = "../../..";
        position = "anywhere";
      };
    };

    plugins = [
      ## Plugin manager (not longer needed)
      # {
      #   name = "fisher";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "jorgebucaran";
      #     repo = "fisher";
      #     rev = "4.4.5";
      #     hash = "sha256-VC8LMjwIvF6oG8ZVtFQvo2mGdyAzQyluAGBoK8N2/QM=";
      #   };
      # }
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "1.0.4";
          hash = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
        };
      }
      {
        name = "puffer";
        src = pkgs.fetchFromGitHub {
          owner = "nickeb96";
          repo = "puffer-fish";
          rev = "v1.0.0";
          hash = "sha256-2niYj0NLfmVIQguuGTA7RrPIcorJEPkxhH6Dhcy+6Bk=";
        };
      }
      {
        name = "upto";
        src = pkgs.fetchFromGitHub {
          owner = "markcial";
          repo = "upto";
          rev = "master";
          hash = "sha256-Lv2XtP2x9dkIkUUjMBWVpAs/l55Ztu7gIjKYH6ZzK4s=";
        };
      }
      {
        name = "fc";
        src = pkgs.fetchFromGitHub {
          owner = "lengyijun";
          repo = "fc-fish";
          rev = "main";
          hash = "sha256-DQQofY5FPdy5kWctlKmi2SRTH7zL9ZpBdrdMx+iX+dA=";
        };
      }
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "master";
          hash = "sha256-3d/qL+hovNA4VMWZ0n1L+dSM1lcz7P5CQJyy+/8exTc=";
        };
      }
      {
        name = "osx-plugin";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-osx";
          rev = "master";
          hash = "sha256-jSUIk3ewM6QnfoAtp16l96N1TlX6vR0d99dvEH53Xgw=";
        };
      }
    ];
  };
}
