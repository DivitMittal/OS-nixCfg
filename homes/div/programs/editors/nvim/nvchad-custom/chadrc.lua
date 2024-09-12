-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

return {
  base46 = {
    theme = "gatekeeper",
    transparency = true,
    integrations = {
      "git",
      "cmp",
      "blankline",
    },

    -- highlights
    hl_override = {
      Comment = { italic = true, },
    },
    hl_add = {
      NvimTreeOpenedFolderName = { fg = "green", bold = true },
    },
  },

  ui ={
    cmp = {
      icons = true,
      lspkind_text = true,
    },
    nvdash = {
      load_on_startup = false,
    },
    statusline = {
      separator_style = "round",
    },
  },

  lsp = {
    signature = true,
  },

  mason = {
    cmd = true,
    pkgs = {
      -- lua stuff
      "lua-language-server",
      "stylua",

      -- web dev stuff
      "css-lsp",
      "html-lsp",
      "typescript-language-server",
      "deno",
      "prettier",

      -- c/cpp stuff
      "clangd",
      "clang-format",
    },
  },
}