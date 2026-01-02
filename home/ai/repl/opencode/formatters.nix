_: {
  programs.opencode.settings.formatter = {
    nix = {
      command = ["alejandra"];
      extensions = [".nix"];
    };
    lua = {
      command = ["stylua" "-"];
      extensions = [".lua"];
    };
    c-cpp = {
      command = ["clang-format"];
      extensions = [".c" ".cpp" ".cc" ".cxx" ".h" ".hpp"];
    };
    web = {
      command = ["prettier" "--stdin-filepath" "file.ts"];
      extensions = [".html" ".css" ".js" ".jsx" ".ts" ".tsx" ".json" ".md" ".yaml" ".yml"];
    };
    python = {
      command = ["black" "-"];
      extensions = [".py"];
    };
    shell = {
      command = ["shfmt"];
      extensions = [".sh" ".bash"];
    };
    fish = {
      command = ["fish_indent"];
      extensions = [".fish"];
    };
    haskell = {
      command = ["ormolu"];
      extensions = [".hs" ".lhs"];
    };
    swift = {
      command = ["swift-format"];
      extensions = [".swift"];
    };
  };
}
