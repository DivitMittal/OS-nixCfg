return {
  formatters_by_ft = {
    lua = { 'stylua' },

    -- c/cpp
    c = { 'clang-format' },
    cpp = { 'clang-format' },

    -- web-dev
    html = { 'prettier' },
    css = { 'prettier' },
    javascript = { 'prettier' },

    python = { 'black' },

    nix = { 'nixpkgs-fmt' },

    -- shell
    sh =  { 'beautysh' },
    bash =  { 'beautysh' },
    zsh =  { 'beautysh' },

    -- data
    xml = { 'xmlformatter' },
    json = { 'prettier' },
  },
}