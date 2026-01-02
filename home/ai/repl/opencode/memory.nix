_: {
  programs.opencode.rules = ''
    ## External File Loading

    CRITICAL: When you encounter a file reference (e.g., @rules/general.md), use your Read tool to load it on a need-to-know basis. They're relevant to the SPECIFIC task at hand.

    Instructions:

    - Do NOT preemptively load all references - use lazy loading based on actual need
    - When loaded, treat content as mandatory instructions that override defaults
    - Follow references recursively when needed

    ---

    ## Git Workflow Rules

    ### Commits
    - Use Conventional Commits format: `type(scope): description`
    - Keep commits atomic (one logical change per commit)
    - Write imperative mood ("add feature" not "added feature")
    - Reference issues when applicable: `fixes #123`

    ### Branches
    - `main` is protected - never force push
    - Feature branches: `feat/description`
    - Fix branches: `fix/issue-number` or `fix/description`
    - Keep branches short-lived

    ### Before Committing
    - Run `nix fmt` on changed Nix files
    - Run `nix flake check` for Nix projects
    - Review diff before staging

    ---

    ## Security Rules

    ### Secrets
    - NEVER commit secrets, API keys, passwords, or tokens
    - Use agenix/ragenix for encrypted secrets
    - Check `.env` files are in `.gitignore`
    - Audit file permissions for sensitive data

    ### Code
    - Validate all external input
    - Use parameterized queries (no string interpolation for commands)
    - Prefer allowlists over denylists
    - Log security events but never log secrets

    ### Nix Specific
    - Use `lib.escapeShellArg` for shell arguments
    - Avoid `builtins.fetchurl` without hash
    - Review systemd service sandboxing options
    - Check firewall rules for exposed services

    ---

    ## Documentation Rules

    ### Comments
    - Explain "why" not "what"
    - Document non-obvious behavior
    - Keep comments up-to-date with code
    - Use `## Section` comments to organize long files

    ### README
    - Include: purpose, installation, usage, configuration
    - Keep examples working and tested
    - Document environment requirements

    ### Nix Modules
    - Add `description` to all `mkOption`
    - Document module dependencies
    - Include usage examples in comments

    ---

    ## Code Quality Rules

    ### General
    - Prefer pure functions over side effects
    - Keep functions small and focused
    - Avoid deep nesting (max 3-4 levels)
    - Use early returns to reduce indentation

    ### Error Handling
    - Handle errors explicitly
    - Provide helpful error messages
    - Fail fast and loud in development
    - Never silently swallow errors

    ### Nix Specific
    - Use `lib.mkMerge` for complex conditional configs
    - Prefer `lib.optionalAttrs` over `if-then-else {}`
    - Use `lib.filterAttrs` to remove null/empty values
    - Avoid `with` - use explicit `lib.` prefix

    ### Type Safety
    - Never use `as any` or `@ts-ignore` (TypeScript)
    - Define proper types for all function parameters
    - Use `lib.types.*` for Nix module options
  '';
}
