return {
  ensure_installed = {
    -- nvim
    'vim',
    'vimdoc',
    'lua',

    -- web-dev
    'html',
    'css',
    'javascript',

    -- languages
    'c',
    'cpp',
    'commonlisp',
    'java',
    'groovy',
    'python',

    -- sysadmin
    'bash',
    'nix',
    'powershell',

    -- git
    'diff',
    'gitignore',
    'gitcommit',

    -- data
    'markdown',
    'markdown_inline',
    'csv',
    'kdl',
    'json',
    'jsonc',
    'xml',
    'ini',
    'toml',
    'yaml',
  },
  sync_install = false, -- synchronous install of ensure_installed
  auto_install = false, -- auto install of ensure_installed
  indent = {
    enable = true,
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
}