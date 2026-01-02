_: {
  programs.claude-code.memory = {
    text = ''
      Follow the coding standards defined in:
      - @~/.claude/rules/git-workflow.md - Git commit and branch conventions
      - @~/.claude/rules/security.md - Security best practices
      - @~/.claude/rules/documentation.md - Documentation standards
      - @~/.claude/rules/code-quality.md - General code quality guidelines
    '';
  };
}
