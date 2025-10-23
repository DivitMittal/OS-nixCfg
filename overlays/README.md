# Overlays Directory

This directory contains Nix package overlays that modify or extend the nixpkgs package set.

## Structure

```
overlays/
├── default.nix       # Main overlay composition
├── nixpkgs.nix       # Package modifications and additions
└── ...               # Additional overlay files
```

## Purpose

Overlays provide:

- **Package modifications** - Patch or customize existing packages
- **New packages** - Add packages not in nixpkgs
- **Version pinning** - Use specific versions of packages
- **Cross-package changes** - Modify multiple related packages
- **nixpkgs integration** - Access to multiple nixpkgs channels

## Current Overlays

### default.nix

Exports all overlays for use in the flake:

- `default` - Main overlay combining all others
- `pkgs-master` - Access to nixpkgs master branch
- `pkgs-nixos` - NixOS stable packages
- `pkgs-darwin` - macOS-specific stable packages
- `custom` - Custom package definitions

### nixpkgs.nix

Package set modifications:

- Custom package versions
- Patched packages
- Package additions from `../pkgs/`

## Creating Overlays

### Basic Overlay Structure

```nix
# overlays/my-overlay.nix
final: prev: {
  # Modify an existing package
  myPackage = prev.myPackage.overrideAttrs (old: {
    version = "2.0.0";
    src = final.fetchurl {
      url = "https://example.com/mypackage-2.0.0.tar.gz";
      sha256 = "...";
    };
  });

  # Add a new package
  myNewPackage = final.callPackage ../pkgs/my-new-package {};
}
```

### Overlay Types

**Package Modification:**

```nix
final: prev: {
  # Override package attributes
  firefox = prev.firefox.override {
    enableGnomeExtensions = true;
  };

  # Modify derivation
  git = prev.git.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [ final.libsecret ];
  });
}
```

**New Package:**

```nix
final: prev: {
  myTool = final.callPackage ../pkgs/mytool {
    # Dependencies
    inherit (final) lib stdenv fetchFromGitHub;
  };
}
```

**Version Pinning:**

```nix
final: prev: {
  # Use specific nixpkgs version
  nodejs = final.pkgs-master.nodejs;

  # Pin to specific version
  terraform = prev.terraform.overrideAttrs (old: {
    version = "1.5.0";
    # ...
  });
}
```

## Using Overlays

### Automatic Application

Overlays are automatically applied to all systems via the flake configuration:

```nix
# In flake.nix
_module.args.pkgs = import nixpkgs {
  inherit system;
  overlays = [
    self.overlays.default
    self.overlays.pkgs-master
    # ...
  ];
};
```

### Manual Application

Apply overlay in specific context:

```nix
{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      myPackage = final.callPackage ../pkgs/mypackage {};
    })
  ];
}
```

## Common Patterns

### Accessing Multiple nixpkgs Versions

```nix
# In configuration
{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.stable.firefox      # From stable channel
    pkgs.pkgs-master.neovim  # From master
    pkgs.myCustomPkg         # From custom overlay
  ];
}
```

### Conditional Overlays

```nix
final: prev: {
  # Only on Linux
  linuxTool = if final.stdenv.isLinux
    then final.callPackage ../pkgs/linux-tool {}
    else null;

  # Only on Darwin
  darwinApp = if final.stdenv.isDarwin
    then final.callPackage ../pkgs/darwin-app {}
    else null;
}
```

### Cascading Changes

```nix
final: prev: {
  # Modify dependency
  libfoo = prev.libfoo.overrideAttrs (old: {
    patches = [ ./fix-libfoo.patch ];
  });

  # All packages using libfoo automatically get the patched version
  bar = prev.bar;  # Uses new libfoo
  baz = prev.baz;  # Uses new libfoo
}
```

## Best Practices

### When to Use Overlays

Use overlays for:

- ✅ Modifying packages system-wide
- ✅ Adding custom packages to nixpkgs
- ✅ Maintaining package versions across hosts
- ✅ Patching upstream packages

### When NOT to Use Overlays

Don't use overlays for:

- ❌ Host-specific package selection (use host config)
- ❌ User packages (use home-manager)
- ❌ One-off package modifications (use override directly)
- ❌ Testing (overlay affects all systems)

### Overlay Guidelines

1. **Name Clearly**: Use descriptive names for overlay files
2. **Document Changes**: Comment why packages are modified
3. **Test Thoroughly**: Overlays affect entire system
4. **Keep Small**: Each overlay should have a focused purpose
5. **Avoid Conflicts**: Be careful with package name collisions
6. **Use callPackage**: For consistency with nixpkgs

## Examples

### Simple Package Addition

```nix
# overlays/custom-tools.nix
final: prev: {
  myScript = final.writeShellScriptBin "myscript" ''
    echo "Hello from custom script"
  '';

  myTool = final.callPackage ../pkgs/mytool {};
}
```

### Package Modification

```nix
# overlays/vim-config.nix
final: prev: {
  vim-configured = prev.vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = ''
      set number
      set relativenumber
    '';
  };
}
```

### Multi-Channel Access

```nix
# overlays/channels.nix
final: prev: {
  # Expose master channel packages
  pkgs-master = import inputs.nixpkgs-master {
    inherit (final) system;
    config.allowUnfree = true;
  };

  # Expose stable packages
  stable = import inputs.nixpkgs-stable {
    inherit (final) system;
    config.allowUnfree = true;
  };
}
```

### Patching Packages

```nix
# overlays/fixes.nix
final: prev: {
  brokenPackage = prev.brokenPackage.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      # Add fix patch
      (final.fetchpatch {
        url = "https://github.com/project/fix.patch";
        sha256 = "...";
      })
    ];
  });
}
```

## Integration with Custom Packages

Overlays work with the `../pkgs/` directory:

```nix
# overlays/nixpkgs.nix
final: prev: {
  # Import all custom packages
  myPackages = final.callPackage ../pkgs {};

  # Or individual packages
  customTool = final.callPackage ../pkgs/custom-tool {};
}
```

## Related Documentation

- ../pkgs/README.md - Custom package definitions
- ../modules/README.md - Custom modules
- [Nixpkgs Manual - Overlays](https://nixos.org/manual/nixpkgs/stable/#chap-overlays)
- [NixOS Wiki - Overlays](https://nixos.wiki/wiki/Overlays)
