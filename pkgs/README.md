# Packages Directory

This directory contains custom package definitions that are not available in nixpkgs or require custom builds.

## Structure

```
pkgs/
├── custom/       # Custom package derivations
├── darwin/       # macOS-specific packages
├── pypi/         # Python packages from PyPI
└── ...           # Other package categories
```

## Purpose

Custom packages provide:

- **Unavailable packages** - Software not in nixpkgs
- **Custom builds** - Modified or patched versions
- **Internal tools** - Project-specific utilities
- **Binary packages** - Pre-built software
- **Language-specific packages** - PyPI, npm, etc.

## Package Categories

### custom/

General custom package derivations:

- Tools specific to this setup
- Patched versions of upstream software
- Custom scripts and utilities

### darwin/

macOS-specific packages:

- GUI applications for macOS
- System utilities
- macOS-only tools
- Homebrew cask alternatives

Common Darwin packages:

- `.app` bundles
- macOS system extensions
- Native macOS applications

### pypi/

Python packages from PyPI:

- Python libraries not in nixpkgs
- Specific versions of Python packages
- Custom Python tools

## Creating Packages

### Basic Package Structure

```nix
# pkgs/custom/mytool/default.nix
{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "mytool";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "username";
    repo = "mytool";
    rev = "v${version}";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ /* runtime dependencies */ ];

  installPhase = ''
    mkdir -p $out/bin
    cp mytool $out/bin/
  '';

  meta = with lib; {
    description = "A useful tool";
    homepage = "https://github.com/username/mytool";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
```

### Script Package

```nix
# pkgs/custom/myscript/default.nix
{writeShellScriptBin, ...}:

writeShellScriptBin "myscript" ''
  #!/usr/bin/env bash
  echo "Hello from custom script!"
  # Your script here
''
```

### Python Package

```nix
# pkgs/pypi/mylib/default.nix
{
  lib,
  python3Packages,
  fetchPypi,
}:

python3Packages.buildPythonPackage rec {
  pname = "mylib";
  version = "1.2.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  propagatedBuildInputs = with python3Packages; [
    requests
    click
  ];

  meta = with lib; {
    description = "My Python library";
    homepage = "https://pypi.org/project/mylib/";
    license = licenses.mit;
  };
}
```

### macOS App Bundle

```nix
# pkgs/darwin/myapp/default.nix
{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
}:

stdenvNoCC.mkDerivation rec {
  pname = "MyApp";
  version = "1.0.0";

  src = fetchurl {
    url = "https://example.com/MyApp-${version}.dmg";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ undmg ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications/
  '';

  meta = with lib; {
    description = "My macOS Application";
    homepage = "https://example.com";
    platforms = platforms.darwin;
  };
}
```

## Using Custom Packages

### Via Overlays

Packages are automatically exposed via overlays:

```nix
{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.mytool        # From custom packages
    pkgs.myapp         # From darwin packages
  ];
}
```

### Direct Import

```nix
{pkgs, ...}: let
  mytool = pkgs.callPackage ../pkgs/custom/mytool {};
in {
  environment.systemPackages = [ mytool ];
}
```

## Package Organization

### Directory Structure

```
pkgs/category/packagename/
├── default.nix         # Main package definition
├── patches/            # Patch files
│   └── fix-build.patch
└── vendor/             # Vendored dependencies
    └── lib.tar.gz
```

### Multi-Package Directory

```nix
# pkgs/custom/default.nix
{callPackage, ...}: {
  tool1 = callPackage ./tool1 {};
  tool2 = callPackage ./tool2 {};
  tool3 = callPackage ./tool3 {};
}
```

## Best Practices

### When to Add Custom Packages

Add custom packages for:

- ✅ Software not in nixpkgs
- ✅ Specific versions not available
- ✅ Patched or modified software
- ✅ Internal tools and scripts
- ✅ Binary-only software

### When NOT to Add Custom Packages

Don't create custom packages for:

- ❌ Software already in nixpkgs (use override instead)
- ❌ One-off scripts (use writeShellScript directly)
- ❌ Temporary testing
- ❌ Upstream packages (contribute to nixpkgs instead)

### Package Guidelines

1. **Follow nixpkgs conventions** - Use standard patterns
2. **Add metadata** - Include description, homepage, license
3. **Pin versions** - Specify exact versions
4. **Document patches** - Explain why patches are needed
5. **Test builds** - Verify packages build successfully
6. **Keep updated** - Maintain packages regularly

## Fetching Sources

### From GitHub

```nix
src = fetchFromGitHub {
  owner = "username";
  repo = "project";
  rev = "v1.0.0";  # or commit hash
  sha256 = lib.fakeSha256;  # Replace with actual hash
};
```

### From URL

```nix
src = fetchurl {
  url = "https://example.com/file.tar.gz";
  sha256 = lib.fakeSha256;  # Replace with actual hash
};
```

### From Git

```nix
src = fetchgit {
  url = "https://example.com/repo.git";
  rev = "abc123";
  sha256 = lib.fakeSha256;
};
```

## Getting SHA256 Hashes

```bash
# For fetchurl
nix-prefetch-url https://example.com/file.tar.gz

# For fetchFromGitHub
nix-prefetch-url --unpack https://github.com/owner/repo/archive/v1.0.0.tar.gz

# For fetchgit
nix-prefetch-git https://example.com/repo.git --rev abc123
```

## Testing Packages

```bash
# Build package
nix build .#mypackage

# Build and run
nix run .#mypackage

# Enter development shell
nix develop .#mypackage

# Check package evaluation
nix eval .#mypackage.meta.description
```

## Related Documentation

- ../overlays/README.md - Package overlays
- ../flake/README.md - Flake structure
- [Nixpkgs Manual - Packaging](https://nixos.org/manual/nixpkgs/stable/#chap-quick-start)
- [Nix Pills - Packaging](https://nixos.org/guides/nix-pills/basic-dependencies-and-hooks.html)
