{
  description = "OS-nixCfg flake";
  outputs = {nixpkgs, ...} @ inputs: let
    inherit (inputs.flake-parts.lib) mkFlake;
    specialArgs.lib = nixpkgs.lib.extend (_: super: {
      custom = builtins.import ./lib/custom.nix {lib = super;};
    });
  in
    mkFlake {inherit inputs specialArgs;} ({
      inputs,
      lib,
      self,
      ...
    }: {
      systems = builtins.import inputs.systems;
      perSystem = {system, ...}: {
        #pkgs = inputs.nixpkgs.legacyPackages.${system}; # memoized
        ## non-memoized pkgs
        _module.args.pkgs = builtins.import nixpkgs {
          inherit system;
          config = let
            inherit (lib) mkDefault;
          in {
            allowUnfree = mkDefault true;
            allowBroken = mkDefault false;
            allowUnsupportedSystem = mkDefault false;
            checkMeta = mkDefault false;
            warnUndeclaredOptions = mkDefault true;
          };
          overlays = lib.attrsets.attrValues {
            inherit
              (self.outputs.overlays)
              default
              pkgs-master
              ;
          };
        };
      };
      imports = [
        ./flake
        ./home
        ./hosts
        ./lib
        ./modules
        ./overlays
        ./templates
      ];
    });

  inputs = {
    ### nixpkgs (from most unstable to stable)
    #nixpkgs-staging.url = "github:nixos/nixpkgs/staging";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-nixos.url = "github:nixos/nixpkgs/nixos-25.05";
    ## Nix User Repository (NUR)
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## nixpkgs indexed
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## flake helpers
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    ## flake-parts
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks = {
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
        git-hooks.follows = "git-hooks";
      };
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
      url = "git+ssh://git@github.com/DivitMittal/OS-nixCfg-secrets.git?ref=master";
      #url = "path:/Users/div/Projects/OS-nixCfg-secrets";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        devshell.follows = "devshell";
        agenix.follows = "agenix";
        ragenix.follows = "ragenix";
        actions-nix.follows = "actions-nix";
        git-hooks.follows = "git-hooks";
      };
    };

    ## Editors
    Vim-Cfg = {
      url = "github:DivitMittal/Vim-Cfg";
      #url = "path:/Users/div/Projects/Vim-Cfg";
      flake = false;
    };
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nvchad-starter.follows = "Vim-Cfg";
      };
    };
    Emacs-Cfg = {
      url = "github:DivitMittal/emacs-cfg";
      #url = "path:/Users/div/Projects/Emacs-Cfg";
      flake = false;
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    ## Firefox
    firefox-nixCfg = {
      #url = "path:/Users/div/Projects/firefox-nixCfg";
      url = "github:DivitMittal/firefox-nixCfg";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
        devshell.follows = "devshell";
        treefmt-nix.follows = "treefmt-nix";
        git-hooks.follows = "git-hooks";
        actions-nix.follows = "actions-nix";
      };
    };

    ## NixOS
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    ## Android
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    ## Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### macOS
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## Hammerspoon
    hammerspoon-nix = {
      url = "github:DivitMittal/hammerspoon-nix";
      #url = "path:/Users/div/Projects/hammerspoon-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
        devshell.follows = "devshell";
        treefmt-nix.follows = "treefmt-nix";
        git-hooks.follows = "git-hooks";
        actions-nix.follows = "actions-nix";
      };
    };
    ## macOS GUI .app bundles
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew"; # Bootstrapping homebrew
    brew-nix = {
      #url = "github:DivitMittal/brew-nix/cask-variation";
      url = "github:BatteredBunny/brew-nix";
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
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        systems.follows = "systems";
      };
    };

    ## Keyboard
    kanata-tray = {
      url = "github:rszyma/kanata-tray";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    TLTR = {
      url = "github:DivitMittal/TLTR";
      flake = false;
    };

    ## Misc.
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    leetcode-tui = {
      url = "github:akarsh1995/leetcode-tui";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    aicommit2 = {
      #url = "path:/Users/div/Projects/Forks/aicommit2";
      #url = "github:DivitMittal/aicommit2/fix-nix-package";
      url = "github:tak-bro/aicommit2";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };
}
