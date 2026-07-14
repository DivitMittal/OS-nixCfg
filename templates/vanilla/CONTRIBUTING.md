# Contributing to {project-name}

Thanks for your interest in contributing — bug reports, fixes, documentation,
and ideas are all welcome.

## Ways to Contribute

- **Bug reports** — open an issue with reproduction steps
- **Fixes and features** — open a pull request
- **Documentation** — improvements to the README, examples, or comments
- **Reviews** — testing, triaging, and reviewing open issues and PRs

## Development Workflow

1. Create a branch from `main`:
   - `feat/short-description` for new functionality
   - `fix/short-description` for bug fixes
   - `docs/short-description` for documentation-only changes
2. Make focused, atomic commits — one logical change per commit
3. Follow [Conventional Commits](https://www.conventionalcommits.org/) for
   commit messages
4. Run the formatter, linter, and tests for your change before pushing
5. Push your branch and open a pull request against `main`

## Commit Messages

```
<type>(<scope>): <short summary>

<body explaining the what and why>

<footer with issue references>
```

Common types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ci`, `perf`,
`build`.

## Pull Requests

A good pull request includes:

- A clear title describing the change
- A description of **why** the change is needed (link the issue if there is one)
- A summary of the approach and any trade-offs considered
- Notes on testing — what you ran, what you couldn't run, and why
- Screenshots or recordings for any user-visible change

PRs are reviewed on a best-effort basis. Expect discussion, requested changes,
and patience — maintainers are volunteers unless stated otherwise.

## Reporting Issues

Open an issue with:

- A clear, descriptive title
- Steps to reproduce (or a minimal failing example)
- Expected vs. actual behavior
- Your environment: OS, language/runtime version, relevant configuration
- Any relevant logs, stack traces, or screenshots

## Code of Conduct

All contributors are expected to follow the project's
[`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).

## Security

Report security issues privately — see [`SECURITY.md`](SECURITY.md). **Do not**
open a public issue for suspected vulnerabilities.

## License

By contributing, you agree that your contributions will be licensed under the
same license as the project (see [`LICENSE`](LICENSE)).
