{
  pkgs,
  inputs,
  ...
}: {
  programs.crush = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${pkgs.system}.crush;

    settings = {
      permissions = {
        allowed_tools = [
          "view"
          "ls"
          "grep"
          "edit"
        ];
      };
      lsp = {
        nix = {
          command = "${pkgs.nixd}/bin/nixd";
        };
      };
      mcp = let
        pnpmCommand = "${pkgs.pnpm}/bin/pnpm";
        # uvCommand = "${pkgs.uv}/bin/uvx";
      in {
        ## modelcontextprotocol
        filesystem = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-filesystem"];
        };
        sequential-thinking = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-sequential-thinking"];
        };
        memory = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "@modelcontextprotocol/server-memory"];
        };
        ## Microsoft
        # playwright = {
        #   type = "stdio";
        #   command = pnpmCommand;
        #   args = ["dlx" "@playwright/mcp"];
        # };
        # markitdown = {
        #   type = "stdio";
        #   command = uvCommand;
        #   args = ["markitdown-mcp"];
        # };
        ## third-party
        deepwiki = {
          type = "http";
          url = "https://mcp.deepwiki.com/mcp";
        };
        octocode = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "octocode-mcp@latest"];
        };
        ddg = {
          type = "stdio";
          command = pnpmCommand;
          args = ["dlx" "duckduckgo-mcp-server"];
        };
      };
    };
  };
}
