# Desktop migration: niri + noctalia → Sway + composed shell

Status: implemented. This document records the rationale, component choices, and
verification steps for replacing the niri/noctalia desktop with Sway and a stack of small,
declaratively-configured Wayland tools.

## Why

The previous desktop was **niri** (scrollable-tiling compositor) + **noctalia** (integrated
Quickshell/QML aesthetic shell). The driving requirement is **descriptive vertical tabs** —
a vertical list of window title bars — which only Sway's `layout stacking` provides. niri's
tab indicator carries no titles and cannot tab the horizontal axis (that axis is its scroll
strip). The desktop priorities are **no animation, utility over aesthetics, and
Nix/declarative-first**, so an integrated QML shell is the wrong fit; a composed stack of
fast Unix tools matches both the priorities and Sway's philosophy.

## Decisions

- **WM:** plain `pkgs.sway` (most nix-friendly; SwayFX would be a 1-line `package` swap later
  if eye-candy is ever wanted — config is identical).
- **Login:** `greetd` + **agreety** (greetd's built-in TUI greeter, bundled in the greetd
  package; tuigreet was rejected as not actively developed).
- **Launcher:** `sway-launcher-desktop` — a TUI/fzf launcher run in a floating wezterm
  (GUI popups like fuzzel/tofi were rejected in favour of a terminal-native launcher).
- **Theming:** all colors/fonts come from **stylix** (`common/home/stylix.nix`, sourced from
  `lib/palette.nix`); the new modules are behavior-only.
- **Night light:** skipped.

## Architecture / wiring

- `home/gui/setup.nix` auto-imports `home/gui/linux/` recursively on Linux, so the new
  `home/gui/linux/sway/` modules are picked up with no manual import; deleting `niri.nix` /
  `noctalia.nix` removes the old desktop.
- The nixos system (`hts`) and the standalone home-manager config (`hms`) are separate
  builds. The Sway HM stack applies via `hms`; greetd and the system desktop bits via `hts`.
- `config.hostSpec.hostName` (set in `flake/mkCfg.nix`) gates the system desktop module off
  the headless **WSL** host. WSL is dev-only and must never receive desktop config.

## Components

### Home-manager — `home/gui/linux/sway/`

- `sway.nix` — WM core, keybinds (incl. `layout stacking` for descriptive vertical tabs),
  wezterm terminal, swaybg, startup (polkit agent, cliphist).
- `bar.nix` — swaybar + `programs.i3status-rust`.
- `launcher.nix` — `sway-launcher-desktop` (floating wezterm) + `sway-easyfocus`.
- `notify-osd.nix` — `services.mako` + `services.swayosd`.
- `session.nix` — `services.kanshi` + `services.swayidle` + `programs.swaylock`.
- `tools.nix` — grim, slurp, satty, wl-clipboard, cliphist, brightnessctl, playerctl,
  wf-recorder, lxqt-policykit, with screenshot/clipboard keybinds.

### System — `common/hosts/nixos/desktop.nix` (gated `hostName != "WSL"`)

- `services.greetd` → `agreety --cmd sway`
- `security.polkit.enable`, `security.pam.services.swaylock`
- `xdg.portal` (wlr + gtk backends)
- `programs.dconf.enable`

## Component provenance (audit)

| Component              | Ver    | Upstream                                           | License   |
| ---------------------- | ------ | -------------------------------------------------- | --------- |
| sway (+ swaybar)       | 1.11   | https://github.com/swaywm/sway                     | MIT       |
| i3status-rust          | 0.36.1 | https://github.com/greshake/i3status-rust          | GPL-3.0   |
| sway-launcher-desktop  | 1.7.0  | https://github.com/Biont/sway-launcher-desktop     | GPL-3.0   |
| sway-easyfocus         | 0.2.0  | https://github.com/edzdez/sway-easyfocus           | MIT       |
| mako                   | 1.11.0 | https://github.com/emersion/mako                   | MIT       |
| swayosd                | 0.3.1  | https://github.com/ErikReider/SwayOSD              | GPL-3.0+  |
| kanshi                 | 1.8.0  | https://gitlab.freedesktop.org/emersion/kanshi     | MIT       |
| swayidle               | 1.9.0  | https://github.com/swaywm/swayidle                 | MIT       |
| swaylock               | 1.8.5  | https://github.com/swaywm/swaylock                 | MIT       |
| grim                   | 1.5.0  | https://gitlab.freedesktop.org/emersion/grim       | MIT       |
| slurp                  | 1.5.0  | https://github.com/emersion/slurp                  | MIT       |
| satty                  | 0.20.1 | https://github.com/gabm/Satty                      | MPL-2.0   |
| wl-clipboard           | 2.3.0  | https://github.com/bugaevc/wl-clipboard            | GPL-3.0+  |
| cliphist               | 0.7.0  | https://github.com/sentriz/cliphist                | GPL-3.0   |
| brightnessctl          | 0.5.1  | https://github.com/Hummer12007/brightnessctl       | MIT       |
| playerctl              | 2.4.1  | https://github.com/altdesktop/playerctl            | LGPL-3.0  |
| wf-recorder            | 0.6.0  | https://github.com/ammen99/wf-recorder             | MIT       |
| lxqt-policykit         | 2.3.0  | https://github.com/lxqt/lxqt-policykit             | LGPL-2.1+ |
| greetd (+ agreety)     | 0.10.3 | https://sr.ht/~kennylevinsen/greetd/               | GPL-3.0+  |
| xdg-desktop-portal-wlr | 0.8.1  | https://github.com/emersion/xdg-desktop-portal-wlr | MIT       |
| xdg-desktop-portal-gtk | 1.15.3 | https://github.com/flatpak/xdg-desktop-portal-gtk  | LGPL-2.1+ |

## Verification

1. `nix fmt` then `nix flake check`.
2. Smoke-test nested (before relying on the greeter): from a running session, launch a
   nested `sway` in a terminal and confirm config parses, `layout stacking` gives descriptive
   vertical tabs, `Mod+d` floats the launcher, the bar renders.
3. `hms -v --show-trace` (apply the Sway HM stack).
4. `hts -v --show-trace` (apply greetd + system bits; confirm WSL still builds with no greetd).
5. Reboot → agreety → Sway. Verify tabs, bar, launcher, `notify-send` → mako, volume/
   brightness → swayosd, screenshot keybind, idle → swaylock.

## Rollback

`git revert`/checkout restores niri+noctalia; the previous NixOS generation is selectable at
boot; the greetd `--cmd` can be temporarily repointed.
