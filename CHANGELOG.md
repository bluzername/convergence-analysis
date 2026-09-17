# Changelog

## Unreleased

- Packaged the prompt as a Claude Code skill at `skills/converge/SKILL.md` (with `name` and `description` frontmatter) instead of a bare `converge.md` command file. It is still invoked as `/converge`.
- `install.sh` now installs to `$CLAUDE_DIR/skills/converge/SKILL.md` (default `~/.claude`), supports `--dry-run`, and warns if a legacy `commands/converge.md` copy is present.
- Added CI (shellcheck, frontmatter and `$ARGUMENTS` check, install test into a temp directory, dash-character check) and weekly Dependabot for GitHub Actions.
- The prompt refers to the `Agent` tool (the former `Task` tool name) for spawning parallel approaches.

## 2026-04-08

- Initial release as `converge.md`.
