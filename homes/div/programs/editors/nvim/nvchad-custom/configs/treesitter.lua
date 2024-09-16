return {
  ensure_installed = {
    "vim",
    "vimdoc",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  sync_install = false, --synchronous install of ensure_installed
  auto_install = false, --auto install of ensure_installed
  indent = {
    enable = true,
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
}