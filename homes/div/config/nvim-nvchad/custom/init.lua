local g       = vim.g                             -- global vim variable
local set     = vim.opt                           -- global options
local cmd     = vim.cmd                           -- execute Vim commands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- local fn      = vim.fn                      -- call Vim functions
-- local b       = vim.bo                      -- buffer  -scoped options
-- local w       = vim.wo                      -- windows -scoped options
-- local exec    = vim.api.nvim_exec                 -- execute Vimscript

-- ────────────────❰ Leader Mapping ❱─────────────── --
-- g.mapleader = ' '                                      -- default nvim leader is '\' & default NvChad leader is ' '
g.maplocalleader = "|"

-- ────────────────❰ Settings ❱─────────────── --
set.termguicolors = true -- Enable GUI colors for the terminal to get truecolor
set.list = true          -- show whitespace
set.listchars = {
    nbsp = "␣",
    extends = "»",
    precedes = "«",
    tab = "|-",
    trail = "•",
    space = "·",
    eol = "ꜜ",
}

set.fillchars = {
    diff = "∙",
    eob = " ", -- NOBREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold = "·",
    vert = " ", -- remove ugly vertical lines on window division
}

set.wrap              = true        -- automatically wrap on load
set.breakindent       = true        -- automatically break lines on load with respect to indent
-- set.cursorcolumn   = true                                 -- highlight current column
-- set.cursorline     = true                                 -- highlight current line
set.number            = true                                   -- show line numbers
set.relativenumber    = true                                   -- show relative line number
set.mouse             = "a"                                    -- turn on mouse interaction
set.laststatus        = 2                                      -- always show status line
set.wildignore        = set.wildignore + "*.o,*.rej,*.so"      -- patterns to ignore during file-navigation
--  set.scrolloff     = 1                                 -- when scrolling, keep cursor 1 lines away from screen border
--  set.sidescrolloff = 2                                 -- keep 30 columns visible left and right of the cursor at all times
set.backspace         = "indent,start,eol"             -- make backspace behave like normal again
set.lazyredraw        = true                           -- faster scrolling
set.expandtab         = true                           -- expand tabs into spaces
set.updatetime        = 1000                           -- CursorHold interval
set.completeopt       = "menuone,noselect,noinsert"    -- completion options
set.inccommand        = "split"                        -- live preview of :s results

set.clipboard         = set.clipboard + "unnamedplus"  -- copy & paste
set.showmatch         = true                           -- show the matching part of the pair for [] {} and ()

set.incsearch         = true                           -- incremental search
set.hlsearch          = true                           -- highlighted search results
set.ignorecase        = true                           -- ignore case sensetive while searching
set.smartcase         = true                           -- being smart about ignoring case when using ignorecase

set.shiftround        = true                         -- round shiftwidth to the nearest multiple of shiftwidth
-- plugin guess-indent sets the following dynamically & editorconfig sets the defaults
--set.shiftwidth  = 4                                     -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
--set.tabstop     = 4                                     -- actual spaces which are considered a tab
--set.smarttab    = true                                  -- <tab>/<BS> indent/dedent in leading whitespace
--set.softtabstop = 4                                     -- how many spaces are inserted and delted when pressing tab and bs respectively
set.smartindent = true                -- indent the current line according to the previous line
set.autoindent  = true                -- maintain indent of current line

set.shell       = "/usr/bin/env fish" -- shell to use for `!`, `:!`, `system()` etc.

set.splitbelow  = true                -- open horizontal splits below current window
set.splitright  = true                -- open vertical splits to the right of the current window

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ Automate ❱━━━━━━━━━━━━━━━━━━━━ --
autocmd("TextYankPost", {
  group = augroup("yank_highlight", {clear = true}),
  pattern = "?*",
  callback = function() vim.highlight.on_yank{higroup="IncSearch",timeout=500,on_visual=true} end,
})


autocmd("BufReadPost", {
  pattern = "?*",
  group = augroup("jump_to_last_position", {clear = true}),
  callback = function() cmd([[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]) end,
})

autocmd("BufWritePre", {
  pattern = "?*",
  group = augroup("remove_trailing_whitespaces", {clear = true}),
  callback = function() cmd([[%s/\s\+$//e]]) end,
})

autocmd("BufEnter", {
  pattern = "?*",
  group = augroup("no_autocomment_new_lines", {clear = true}),
  callback = function() vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' }) end,
})

autocmd("VimResized", {
    pattern = "*",
    group = augroup("pane_resize", {clear = true}),
    callback = function () cmd[[tabdo wincmd =]] end,
})

-- Auto save views
autocmd("BufWinLeave", {
  pattern = "?*",
  group = augroup("remember_folds", {clear = true}),
  callback = function() cmd([[silent! mkview]]) end,
})

autocmd("BufWinEnter", {
  pattern = "?*",
  group = augroup("remember_folds", {clear = true}),
  callback = function() cmd([[silent! loadview]]) end,
})