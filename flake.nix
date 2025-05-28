{
  description = "OS-nixCfg flake";
  outputs = {nixpkgs, ...} @ inputs: let
    inherit (inputs.flake-parts.lib) mkFlake;
    lib = nixpkgs.lib;
    specialArgs.lib = lib.extend (_: super: {
      custom = builtins.import ./lib/custom.nix {inherit lib;};
    });
  in
    mkFlake {inherit inputs specialArgs;} ({inputs, ...}: {
      systems = builtins.import inputs.systems;
      imports = [
        ./flake
        ./home
        ./hosts
        ./lib
        ./modules
        ./overlays
      ];
    });

  inputs = {
    ## nixpkgs (from most unstable to stable)
    #nixpkgs-staging.url = "github:nixos/nixpkgs/staging";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-nixos.url = "github:nixos/nixpkgs/nixos-25.05";

    ## flake helpers
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    ## flake modules
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    actions-nix = {
      url = "github:nialov/actions.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
    };

    ## nix-darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs = {
        nix-darwin.follows = "nix-darwin";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        darwin.follows = "nix-darwin";
        systems.follows = "systems";
      };
    };
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs = {
        agenix.follows = "agenix";
        nixpkgs.follows = "nixpkgs";
      };
    };
    OS-nixCfg-secrets = {
      url = "git+ssh://git@github.com/divitmittal/os-nixcfg-secrets.git?ref=master";
      #url = "path:/Users/div/Projects/OS-nixCfg-secrets";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        devshell.follows = "devshell";
        agenix.follows = "agenix";
        ragenix.follows = "ragenix";
        actions-nix.follows = "actions-nix";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
    };

    ## editors
    Nvim-Cfg = {
      url = "github:divitmittal/nvim-cfg";
      #url = "path:/Users/div/Projects/Nvim-Cfg";
      flake = false;
    };
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nvchad-starter.follows = "Nvim-Cfg";
      };
    };

    ## Firefox
    betterfox-nix = {
      url = "github:heitoraugustoln/betterfox-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-firefox-darwin = {
      url = "github:divitmittal/nixpkgs-firefox-darwin/extra-files";
      #url = "path:/Users/div/Projects/Forks/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Homebrew Casks pkgs overlay
    brew-nix = {
      url = "github:divitmittal/brew-nix/cask-variation";
      #url = "github:BatteredBunny/brew-nix";
      #url = "path:/Users/div/Projects/Forks/brew-nix";
      inputs = {
        brew-api.follows = "brew-api";
        nix-darwin.follows = "nix-darwin";
        nixpkgs.follows = "nixpkgs";
      };
    };
    brew-api = {
      url = "github:batteredbunny/brew-api";
      flake = false;
    };

    ## Other external pkgs
    kanata-tray = {
      url = "github:rszyma/kanata-tray";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    leetcode-tui = {
      url = "github:akarsh1995/leetcode-tui";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };
}