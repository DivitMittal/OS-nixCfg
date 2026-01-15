_: {
  programs.claude-code.commands = {
    ## Git workflows
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

    pr = ''
      ---
      allowed-tools: Bash(git:*), Bash(gh:*)
      argument-hint: [title]
      description: Create a pull request with description
      ---
      ## Context

      - Current branch: !`git branch --show-current`
      - Default branch: !`gh repo view --json defaultBranchRef -q .defaultBranchRef.name 2>/dev/null || echo "main"`
      - Commits not in main: !`git log main..HEAD --oneline 2>/dev/null || git log origin/main..HEAD --oneline 2>/dev/null`
      - Changed files: !`git diff main..HEAD --stat 2>/dev/null || git diff origin/main..HEAD --stat 2>/dev/null`
      - Available labels: !`gh label list --limit 15 2>/dev/null | cut -f1`
      - Open PRs for branch: !`gh pr list --head $(git branch --show-current) --json number,url -q '.[0].url' 2>/dev/null`

      ## Task

      Create a pull request:
      1. Check if PR already exists for this branch (skip if so, show URL)
      2. Push current branch to origin if not already pushed: `git push -u origin HEAD`
      3. Create PR with:
         - Title from $ARGUMENTS or infer from commits/branch name
         - Description summarizing changes (use commit messages)
         - `gh pr create --title "..." --body "..." [--label ...] [--draft] [--assignee @me]`
      4. Suggest labels from available ones based on change type
      5. Ask if it should be a draft PR
      6. Report the created PR URL

      ## PR Description Template

      Use this structure for the body:
      ```
      ## Summary
      <brief description of changes>

      ## Changes
      - <bullet points of key changes>

      ## Testing
      <how to test, or "N/A" if not applicable>
      ```
    '';

    changelog = ''
      ---
      allowed-tools: Bash(git log:*), Bash(git diff:*), Read, Edit
      argument-hint: [version]
      description: Update CHANGELOG.md with new entry
      ---
      ## Context

      - Recent commits: !`git log --oneline -20`
      - Current changelog: !`head -50 CHANGELOG.md 2>/dev/null || echo "No CHANGELOG.md found"`

      ## Task

      Update CHANGELOG.md following Keep a Changelog format:
      1. Group changes by type (Added, Changed, Fixed, Removed)
      2. Reference relevant commits/PRs
      3. Use the provided version or determine appropriate version bump
    '';

    fix-issue = ''
      ---
      allowed-tools: Bash(gh:*), Bash(git:*), Read, Edit, Write
      argument-hint: <issue-number>
      description: Fix a GitHub issue
      ---
      ## Context

      - Issue details: !`gh issue view $ARGUMENTS 2>/dev/null || echo "Could not fetch issue"`

      ## Task

      1. Understand the issue from the description and comments
      2. Create a branch named fix/$ARGUMENTS or feature/$ARGUMENTS
      3. Implement the fix following project conventions
      4. Test the changes if applicable
      5. Commit with message referencing the issue (e.g., "fix: description (closes #$ARGUMENTS)")
    '';

    ## Code quality
    review = ''
      ---
      allowed-tools: Read, Grep, Glob, Bash(git diff:*)
      argument-hint: [file-or-path]
      description: Review code for issues
      ---
      ## Context

      - Files to review: $ARGUMENTS or staged changes
      - Diff: !`git diff --cached --stat 2>/dev/null || git diff HEAD --stat`

      ## Task

      Review the code for:
      1. **Bugs**: Logic errors, edge cases, null checks
      2. **Security**: Input validation, secrets, injection
      3. **Performance**: Unnecessary work, memory leaks
      4. **Style**: Naming, complexity, documentation

      Output format:
      - 🔴 Critical (must fix)
      - 🟡 Warning (should fix)
      - 🟢 Suggestion (nice to have)
    '';

    refactor = ''
      ---
      allowed-tools: Read, Edit, Write, Grep, Glob
      argument-hint: <file-or-symbol>
      description: Refactor code while preserving behavior
      ---
      ## Task

      Refactor $ARGUMENTS to improve:
      - Maintainability
      - Remove duplication
      - Simplify complex logic
      - Improve naming

      Rules:
      - Preserve existing behavior exactly
      - Make small, incremental changes
      - Keep changes reviewable
    '';

    human-code-refactor = ''
      ---
      allowed-tools: Read, Edit, Write, Grep, Glob
      argument-hint: <file-or-symbol>
      description: Refactor code to appear human-written by eliminating AI/LLM telltale patterns
      ---

      # Human Code Refactor

      Refactor code to eliminate patterns that signal AI/LLM authorship.

      ## Forbidden Patterns

      ### Comments
      **REMOVE** (obvious/decorative):
      - Decorative blocks (`# ===`, `# ---`, `# ***`)
      - ASCII art headers or section banners
      - Comments restating what code obviously does (`# increment i` above `i += 1`)
      - Generic labels (`# Main entry point`, `# Helper function`, `# Utility method`)
      - Comments repeating variable/function names in prose form
      - "TODO: implement" placeholders unless specifically requested

      **KEEP** (adds value):
      - Technical explanations of WHY not WHAT (`# offset by 1 to skip header row`)
      - Non-obvious edge cases (`# nil check: upstream API returns null on 404`)
      - Performance/algorithm notes (`# O(n log n) - sorted for binary search`)
      - Caveats or gotchas (`# WARN: not thread-safe, caller must hold lock`)
      - Brief clarifications for dense/tricky logic
      - References to specs, tickets, or external docs

      Comments should be terse and technical. When in doubt, keep the comment if it explains something non-obvious from the code itself.

      ### Naming
      - No overly verbose names (`user_authentication_service_handler_manager`)
      - No redundant type suffixes (`user_list_array`, `count_integer`, `is_valid_boolean`)
      - No `_impl`, `_helper`, `_util` suffixes unless codebase convention
      - Prefer short, contextually clear names (`users` not `list_of_user_objects`)

      ### Structure
      - No excessive abstraction for simple tasks
      - No wrapper functions that just call one other function
      - No factory/builder/strategy patterns for trivial operations
      - No unnecessary class hierarchies - use functions when appropriate
      - Inline short operations instead of extracting micro-functions

      ### Formatting
      - No em dashes anywhere in strings or comments; use regular dashes (-) or rewrite
      - No emojis in code, comments, logs, or output
      - No fancy Unicode characters (arrows, bullets, checkmarks) in output
      - No overly formatted console output with boxes or decorative borders
      - No excessive blank lines between every block

      ### Documentation
      - No docstrings that repeat the function name and parameters verbatim
      - No docstrings for self-explanatory functions (`def get_name(): return self.name`)
      - No "Args/Returns/Raises" sections for simple one-liners
      - Docstrings only for complex public APIs or non-obvious behavior

      ### Code Style
      - Allow minor inconsistencies humans naturally have
      - Don't over-optimize or prematurely abstract
      - Keep error messages terse and practical, not overly helpful prose
      - Avoid triple-quoted strings for simple single-line messages
      - Use contractions naturally in user-facing strings when appropriate

      ### Logging/Output
      - No progress messages for sub-second operations
      - No "Successfully completed X" messages unless necessary
      - No verbose status updates for every step
      - Error messages: direct and practical, not apologetic or overly explanatory

      ## Refactoring Checklist

      1. Strip decorative/obvious comments (keep technical ones that add value)
      2. Shorten verbose variable/function names
      3. Inline trivial helper functions
      4. Remove unnecessary abstraction layers
      5. Replace em dashes with hyphens or reword
      6. Remove emojis and Unicode decoration
      7. Delete self-evident docstrings
      8. Consolidate excessive whitespace
      9. Simplify over-engineered patterns
      10. Make error messages terse

      ## Output

      Return only the refactored code. No explanations, summaries, or before/after comparisons unless explicitly requested.
    '';

    ## Documentation
    explain = ''
      ---
      allowed-tools: Read, Grep
      argument-hint: <file-or-symbol>
      description: Explain code in detail
      ---
      Read and explain $ARGUMENTS:
      1. Purpose and responsibility
      2. How it works (high-level flow)
      3. Key dependencies and interactions
      4. Important edge cases or gotchas
    '';

    doc = ''
      ---
      allowed-tools: Read, Edit, Write
      argument-hint: <file-or-symbol>
      description: Generate or improve documentation
      ---
      ## Task

      Document $ARGUMENTS:
      - Add/update inline comments for complex logic
      - Add/update function/module documentation
      - Follow existing documentation style in codebase

      For Nix:
      - Add `description` to mkOption
      - Add comments for non-obvious configuration
    '';

    ## Quick actions
    test = ''
      ---
      allowed-tools: Bash(nix:*), Bash(npm:*), Bash(pytest:*), Bash(cargo:*)
      description: Run project tests
      ---
      Detect and run tests:
      - Nix: `nix flake check`
      - Node: `npm test`
      - Python: `pytest`
      - Rust: `cargo test`

      Report results and any failures.
    '';

    build = ''
      ---
      allowed-tools: Bash(nix:*), Bash(npm:*), Bash(cargo:*)
      description: Build the project
      ---
      Detect and build:
      - Nix flake: `nix build`
      - Nix darwin: `darwin-rebuild build --flake .`
      - Node: `npm run build`
      - Rust: `cargo build`

      Report success or errors.
    '';

    clean = ''
      ---
      allowed-tools: Bash(git:*), Bash(rm:*), Bash(nix:*)
      description: Clean build artifacts and caches
      ---
      Clean up:
      1. Git ignored files (with confirmation)
      2. Nix result symlinks
      3. Build caches (node_modules/.cache, __pycache__, target/)

      Ask before deleting anything significant.
    '';
  };
}
