# AGENTS (home/tty/)

## OVERVIEW

Terminal stack: shells, prompts, editors, multiplexers, finders, VCS, pagers, ASCII utilities.

## STRUCTURE

```
home/tty/
├── shells/       # bash/zsh/fish configs, starship prompt
├── editors/      # nvim, vim, emacs wrappers
├── multiplexers/ # tmux (tmux.conf.local), screen
├── find/         # yazi (yazi.nix/keymap.nix/init.lua), fzf, tv
├── vcs/          # git (default/ancillary), jujutsu
├── pagers/       # bat, less configs
├── ascii/        # fastfetch, fortune, etc.
└── network/      # ssh/mosh
```

## WHERE TO LOOK

| Task            | Location                          | Notes                                             |
| --------------- | --------------------------------- | ------------------------------------------------- |
| Starship prompt | shells/prompt.nix                 | Large (236 lines); multi-shell/lang modules       |
| tmux config     | multiplexers/tmux/tmux.conf.local | DO NOT markers; no TPM lines; respect guard lines |
| yazi config     | find/yazi/yazi.nix                | 700+ lines; file-type openers per OS              |
| yazi keymap     | find/yazi/keymap.nix              | 700+ lines; mode-specific bindings                |
| find tools      | find/fzf.nix, find/tv.nix         | fzf opts, tv pager setup                          |
| git tooling     | vcs/git/{default,ancillary}.nix   | base git + gh/lazygit/transcrypt helpers          |

## CONVENTIONS

- Every subdir uses `imports = lib.custom.scanPaths ./.;` for drop-in modules.
- Platform-specific tweaks embedded (macOS vs linux in yazi openers).
- Prompt/languages modularized inside prompt.nix; avoid inline overrides elsewhere.

## ANTI-PATTERNS

- tmux.conf.local: never add TPM plugin lines; do not edit below markers or uncomment guarded lines.
- WeeChat configs live elsewhere; do not hand-edit here either (see home/comms/irc/weechat/conf warnings).

## NOTES

- yazi configs are main complexity hotspot; consider editing with care and keep structure intact.
- init.lua inside find/yazi/ is only Lua file; rest pure Nix.
- Most modules provide mkOption toggles; keep nullable package options when extending.
