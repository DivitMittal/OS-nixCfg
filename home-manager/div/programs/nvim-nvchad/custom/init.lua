local g       = vim.g                             -- global vim variable
local exec    = vim.api.nvim_exec                 -- execute Vimscript
local set     = vim.opt                           -- global options
local cmd     = vim.cmd                           -- execute Vim commands
local autocmd = vim.api.nvim_create_autocmd       -- Vim auto-commands
-- local fn      = vim.fn                      -- call Vim functions
-- local b       = vim.bo                      -- buffer  -scoped options
-- local w       = vim.wo                      -- windows -scoped options

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

set.wrap = true        -- automatically wrap on load
set.breakindent = true -- automatically break lines on load with respect to indent
-- set.cursorcolumn   = true                                 -- highlight current column
-- set.cursorline     = true                                 -- highlight current line
set.number = true                                  -- show line numbers
set.relativenumber = true                          -- show relative line number
set.mouse = "a"                                    -- turn on mouse interaction
set.laststatus = 2                                 -- always show status line
set.wildignore = set.wildignore + "*.o,*.rej,*.so" -- patterns to ignore during file-navigation
--  set.scrolloff     = 1                                 -- when scrolling, keep cursor 1 lines away from screen border
--  set.sidescrolloff = 2                                 -- keep 30 columns visible left and right of the cursor at all times
set.backspace = "indent,start,eol"            -- make backspace behave like normal again
set.lazyredraw = true                         -- faster scrolling
set.expandtab = true                          -- expand tabs into spaces
set.updatetime = 1000                         -- CursorHold interval
set.completeopt = "menuone,noselect,noinsert" -- completion options
set.inccommand = "split"                      -- live preview of :s results

set.clipboard = set.clipboard + "unnamedplus" -- copy & paste
set.showmatch = true                          -- show the matching part of the pair for [] {} and ()

set.incsearch = true                          -- incremental search
set.hlsearch = true                           -- highlighted search results
set.ignorecase = true                         -- ignore case sensetive while searching
set.smartcase = true                          -- being smart about ignoring case when using ignorecase

set.shiftround = true                         -- round shiftwidth to the nearest multiple of shiftwidth
-- plugin guess-indent sets the following dynamically & editorconfig sets the defaults
--set.shiftwidth  = 4                                     -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
--set.tabstop     = 4                                     -- actual spaces which are considered a tab
--set.smarttab    = true                                  -- <tab>/<BS> indent/dedent in leading whitespace
--set.softtabstop = 4                                     -- how many spaces are inserted and delted when pressing tab and bs respectively
set.smartindent = true          -- indent the current line according to the previous line
set.autoindent = true           -- maintain indent of current line

set.shell = "/usr/bin/env fish" -- shell to use for `!`, `:!`, `system()` etc.

set.splitbelow = true           -- open horizontal splits below current window
set.splitright = true           -- open vertical splits to the right of the current window

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
-- ━━━━━━━━━━━━━━━━━━━❰ Automate ❱━━━━━━━━━━━━━━━━━━━━ --
-- highlight on yank
exec(
    [[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
    augroup end
]],
    false
)

-- jump to the last position when reopening a file
cmd([[
    if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    endif
]])

-- remove trailing whitespaces on save
cmd([[au BufWritePre * :%s/\s\+$//e]])

-- don't auto commenting new lines
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

 -- autocmd({
 --     -- Save folds on buffer leave
 --     pattern = "*",
 --     event = { "BufWinLeave" },
 --     command = "silent mkview",
 -- })
 --
 -- autocmd({
 --     -- Load folds on buffer enter
 --     pattern = "*",
 --     event = { "BufWinEnter" },
 --     command = "silent loadview",
 -- })