# AGENTS (flake/)

## OVERVIEW

Flake-parts layer: universal mkCfg builder, devshells/formatters/checks, CI/topology wiring.

## STRUCTURE

```
flake/
├── mkCfg.nix           # universal host/home builder (class switch)
├── default.nix         # scanPaths auto-import of flake parts
├── devshells.nix       # nix develop env (hms/hts, LSPs, formatters)
├── formatters.nix      # treefmt-nix (alejandra, deadnix, statix, prettier, shfmt)
├── checks.nix          # git-hooks.nix (pre-commit) setup
├── actions/            # GitHub Actions shared settings
└── topology/           # nix-topology config + generated assets
```

## WHERE TO LOOK

| Task             | Location            | Notes                                     |
| ---------------- | ------------------- | ----------------------------------------- | ------ | ----- | ----------------------------------- |
| Build host/home  | mkCfg.nix           | class="nixos                              | darwin | droid | home"; auto includes common modules |
| Devshell tools   | devshells.nix       | exposes hms/hts; LSPs; deploy-rs          |
| Formatting       | formatters.nix      | treefmt config; excludes .github          |
| Pre-commit hooks | checks.nix          | treefmt + safety checks via git-hooks.nix |
| CI wiring        | actions/, topology/ | shared steps, cache, topology generation  |

## CONVENTIONS

- Auto-import flake parts via `lib.custom.scanPaths ./.` in default.nix.
- pkgs not memoized in perSystem (flex overlays across channels).
- mkCfg exposes pkgs.{master,nixosStable,darwinStable} and overlays (NUR, brew-nix, nix-on-droid).
- Secrets input expected for hostSpec; allowUnfree=true, allowUnsupportedSystem=false.

## ANTI-PATTERNS

- Don’t hand-add imports; rely on scanPaths to keep modules discoverable.
- Avoid memoizing pkgs in perSystem (design choice noted in flake.nix comment).

## NOTES

- nix-topology auto-included for nixos class in mkCfg.
- deploy-rs support present; requires SSH key access for hosts.
- formatters/checks run via `nix fmt` and pre-commit; keep .github excluded from treefmt.
