_: {
  programs.opencode.settings.lsp = {
    # Custom LSPs (not built-in to OpenCode)
    nix = {
      command = ["nixd"];
      extensions = [".nix"];
    };
    html = {
      command = ["vscode-html-language-server" "--stdio"];
      extensions = [".html" ".htm"];
    };
    css = {
      command = ["vscode-css-language-server" "--stdio"];
      extensions = [".css" ".scss" ".less"];
    };
    json = {
      command = ["vscode-json-language-server" "--stdio"];
      extensions = [".json" ".jsonc"];
    };
    svelte = {
      command = ["svelteserver" "--stdio"];
      extensions = [".svelte"];
    };
    emmet = {
      command = ["emmet-language-server" "--stdio"];
      extensions = [".html" ".css" ".jsx" ".tsx" ".vue"];
    };
    haskell = {
      command = ["haskell-language-server-wrapper" "--lsp"];
      extensions = [".hs" ".lhs"];
    };
    python = {
      command = ["pylsp"];
      extensions = [".py" ".pyi"];
    };
    lua = {
      command = ["lua-language-server"];
      extensions = [".lua"];
    };
    yaml = {
      command = ["yaml-language-server" "--stdio"];
      extensions = [".yaml" ".yml"];
    };
  };
}
