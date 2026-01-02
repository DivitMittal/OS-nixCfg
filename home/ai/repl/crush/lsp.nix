{pkgs, ...}: {
  programs.crush.settings.lsp = {
    nix = {
      command = "${pkgs.nixd}/bin/nixd";
    };
    html = {
      command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
      args = ["--stdio"];
    };
    css = {
      command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
      args = ["--stdio"];
    };
    json = {
      command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
      args = ["--stdio"];
    };
    svelte = {
      command = "${pkgs.nodePackages.svelte-language-server}/bin/svelteserver";
      args = ["--stdio"];
    };
    emmet = {
      command = "${pkgs.emmet-language-server}/bin/emmet-language-server";
      args = ["--stdio"];
    };
    haskell = {
      command = "${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper";
      args = ["--lsp"];
    };
    python = {
      command = "${pkgs.python3Packages.python-lsp-server}/bin/pylsp";
    };
    lua = {
      command = "${pkgs.lua-language-server}/bin/lua-language-server";
    };
    yaml = {
      command = "${pkgs.yaml-language-server}/bin/yaml-language-server";
      args = ["--stdio"];
    };
  };
}
