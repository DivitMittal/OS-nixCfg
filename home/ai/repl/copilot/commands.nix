_: {
  programs.github-copilot.commands = {
    commit = ''
      ---
      allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
      description: Create git commit(s) with proper message(s)
      ---
      ## Context

      - Current git status: !`git status`
      - Current git diff: !`git diff HEAD`
      - Recent commits: !`git log --oneline -5`

      ## Task

      Analyze the changes and create commit(s) based on the context:

      1. **Multiple commits when**:
         - Changes span multiple logical concerns (e.g., feature + refactor + docs)
         - Changes affect unrelated components or modules
         - User explicitly requests multiple commits or groups of changes

      2. **Single commit when**:
         - All changes relate to a single logical unit of work
         - User specifies a single context or scope
         - Changes form one cohesive story

      3. **Context-limited commits**:
         - If instructed to commit specific files/paths, ONLY stage and commit those files
         - Respect explicit scope boundaries provided by the user
         - Do NOT include unrelated staged or unstaged changes

      Each commit message MUST follow Conventional Commits syntax: `type(scope): description`

      When creating multiple commits:
      - Stage and commit related changes together
      - Use descriptive, focused commit messages for each
      - Maintain logical ordering (dependencies first)
    '';
  };
}
