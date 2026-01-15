{pkgs, ...}: {
  programs.opencode.settings.mcp = {
    sequential-thinking = {
      type = "local";
      command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "@modelcontextprotocol/server-sequential-thinking"];
      enabled = true;
    };
    octocode = {
      type = "local";
      command = ["${pkgs.pnpm}/bin/pnpm" "dlx" "octocode-mcp@latest"];
      enabled = true;
    };
    ## Inherit support in oh-my-opencode fox context7 & exa MCPs
  };
}
