-- ━━━━━━━━━━━━━━━━━━━❰ Filetype ❱━━━━━━━━━━━━━━━━━━━━ --
local ft = vim.filetype

ft.add({
  extension = {
    kbd = 'lisp',
  },
  filename = {
    ['.condarc'] = 'yaml',
    ['tridactylrc'] = 'vim',
    ['ideavimrc'] = 'vim',
  },
  pattern = {
    ['.*conf'] = 'ini',
  },
})

-- ━━━━━━━━━━━━━━━━━━━❰ Automate ❱━━━━━━━━━━━━━━━━━━━━ --
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("VimResized", {
  group = augroup("pane_resize", {clear = true}),
  pattern = "*",
  callback = function () vim.cmd('tabdo wincmd =') end,
})

autocmd("TextYankPost", {
  group = augroup("yank_highlight", {clear = true}),
  pattern = "*",
  callback = function() vim.highlight.on_yank{ higroup="IncSearch", timeout=500, on_visual=true } end,
})

autocmd("BufReadPost", {
  group = augroup("jump_to_last_position", {clear = true}),
  pattern = "?*",
  callback = function() vim.cmd([[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]) end,
})

autocmd("BufWritePre", {
  group = augroup("remove_trailing_whitespaces", {clear = true}),
  pattern = "?*",
  callback = function() vim.cmd([[%s/\s\+$//e]]) end,
})

autocmd("BufReadPost", {
  group = augroup("dont_autocomment_lines", {clear = true}),
  pattern = "?*",
  callback = function() vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' }) end,
})

autocmd("BufReadPost", {
  group = augroup("load_folds", {clear = true}),
  pattern = "?*",
  callback = function() vim.cmd('silent! loadview') end,
})