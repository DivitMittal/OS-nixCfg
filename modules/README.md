# Modules Directory

This directory contains custom NixOS and home-manager modules that extend the base configuration system with reusable components.

## Structure

```
modules/
├── home/         # Custom home-manager modules
├── hosts/        # Custom NixOS/nix-darwin modules
└── default.nix   # Exports all modules
```

## Purpose

Custom modules provide:

- **Reusable configurations** that can be enabled/disabled
- **Abstract interfaces** for complex setups
- **Custom options** with type checking and validation
- **Modular functionality** that can be shared across hosts

## Module Types

### home/

Home-manager modules for user-level functionality:

- Custom program configurations
- User service definitions
- Dotfile management modules
- User environment setup

Example:

```nix
# modules/home/my-editor.nix
{config, lib, pkgs, ...}:
with lib;
{
  options.programs.myEditor = {
    enable = mkEnableOption "My custom editor setup";

    theme = mkOption {
      type = types.str;
      default = "dark";
      description = "Editor theme";
    };
  };

  config = mkIf config.programs.myEditor.enable {
    home.packages = [ pkgs.myEditor ];
    # Additional configuration...
  };
}
```

### hosts/

System-level modules for NixOS and nix-darwin:

- System service definitions
- Hardware configurations
- Network setup modules
- Security configurations

Example:

```nix
# modules/hosts/my-service.nix
{config, lib, pkgs, ...}:
with lib;
{
  options.services.myService = {
    enable = mkEnableOption "My custom service";

    port = mkOption {
      type = types.port;
      default = 8080;
      description = "Service port";
    };
  };

  config = mkIf config.services.myService.enable {
    systemd.services.myService = {
      # Service definition...
    };
  };
}
```

## Module Structure

### Basic Module Template

```nix
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  # Define options
  options.my.module = {
    enable = mkEnableOption "my module";

    option1 = mkOption {
      type = types.str;
      default = "value";
      description = "Description of option1";
    };
  };

  # Define configuration
  config = mkIf config.my.module.enable {
    # Your configuration here
  };
}
```

### Advanced Features

**Multiple Conditions:**

```nix
config = mkMerge [
  (mkIf config.my.module.enable {
    # Always enabled config
  })

  (mkIf (config.my.module.enable && config.my.module.advanced) {
    # Conditional advanced config
  })
];
```

**Type Validation:**

```nix
options.my.module.servers = mkOption {
  type = types.listOf (types.submodule {
    options = {
      host = mkOption { type = types.str; };
      port = mkOption { type = types.port; };
    };
  });
  default = [];
};
```

## Using Modules

### In Flake Configuration

Modules are automatically exported and can be used in host configurations:

```nix
# In flake.nix or host config
{
  imports = [
    inputs.self.nixosModules.my-module
    # or for home-manager:
    inputs.self.homeModules.my-module
  ];

  # Enable the module
  my.module.enable = true;
  my.module.option1 = "custom-value";
}
```

### Direct Import

```nix
# In any configuration
{
  imports = [
    ../modules/home/my-editor.nix
  ];

  programs.myEditor = {
    enable = true;
    theme = "light";
  };
}
```

## Best Practices

### When to Create a Module

Create a custom module when:

- ✅ Configuration will be reused across multiple hosts/users
- ✅ Setup is complex and benefits from abstraction
- ✅ You need options with validation
- ✅ Multiple related settings should be grouped

### When NOT to Create a Module

Don't create a module if:

- ❌ Configuration is host-specific (use host config directly)
- ❌ It's a simple one-liner (put in appropriate directory)
- ❌ It's experimental or temporary
- ❌ Upstream module already exists in nixpkgs

### Module Design Principles

1. **Single Responsibility**: One module, one purpose
2. **Sensible Defaults**: Work out-of-the-box with minimal config
3. **Documentation**: Describe every option clearly
4. **Type Safety**: Use proper types for validation
5. **Conditional Logic**: Use `mkIf` for optional features
6. **No Side Effects**: Avoid global state modifications

## Common Option Types

```nix
# Boolean
enable = mkEnableOption "feature";

# String
name = mkOption { type = types.str; };

# Integer
port = mkOption { type = types.port; };  # 0-65535

# List
packages = mkOption { type = types.listOf types.package; };

# Path
configFile = mkOption { type = types.path; };

# Enum
theme = mkOption {
  type = types.enum ["dark" "light" "auto"];
};

# Submodule
server = mkOption {
  type = types.submodule {
    options = {
      host = mkOption { type = types.str; };
      port = mkOption { type = types.port; };
    };
  };
};
```

## Examples

### Simple Home Module

```nix
# modules/home/better-ls.nix
{config, lib, pkgs, ...}:
with lib; {
  options.programs.betterLs = {
    enable = mkEnableOption "better ls with exa/eza";
  };

  config = mkIf config.programs.betterLs.enable {
    home.packages = [ pkgs.eza ];
    home.shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
    };
  };
}
```

### System Service Module

```nix
# modules/hosts/backup-service.nix
{config, lib, pkgs, ...}:
with lib; {
  options.services.myBackup = {
    enable = mkEnableOption "automated backup service";

    destination = mkOption {
      type = types.str;
      description = "Backup destination path";
    };

    interval = mkOption {
      type = types.str;
      default = "daily";
      description = "Backup interval (systemd timer format)";
    };
  };

  config = mkIf config.services.myBackup.enable {
    systemd = {
      services.my-backup = {
        script = ''
          ${pkgs.rsync}/bin/rsync -av /data ${config.services.myBackup.destination}
        '';
        serviceConfig.Type = "oneshot";
      };

      timers.my-backup = {
        wantedBy = [ "timers.target" ];
        timerConfig.OnCalendar = config.services.myBackup.interval;
      };
    };
  };
}
```

## Related Documentation

- ../home/README.md - Home-manager configurations
- ../hosts/README.md - Host configurations
- ../common/README.md - Shared configurations
- [NixOS Manual - Writing Modules](https://nixos.org/manual/nixos/stable/index.html#sec-writing-modules)
