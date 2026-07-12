# conf-n-claude

Scrubbed backup of my Claude Code setup.

## Layout

- `claude/` - mirror of `~/.claude`: `CLAUDE.md`, `settings.json`, `settings.local.json`, `statusline.sh`, and per-project memory under `projects/*/memory/`.
- `home/` - `OPINIONS.md` and `VOICE.md`, which live at `~` and are read by agents via `claude/CLAUDE.md`.

## Refreshing

Run `./sync.sh` to regenerate `claude/` and `home/` from the live files and scrub them in one step.
It derives the machine username from `$HOME` and the owner handle/email from git config, and fails loudly if any identifier survives the scrub.
Extra literals to scrub (e.g. personal email addresses) go in `.scrub-extra`, which is gitignored so the identifiers never land in the repo.

## Scrubbing

Personal identifiers were removed before committing.
Names and emails are replaced with placeholders (`OWNER`, `owner@example.com`), including in memory files and project directory names (`-Users-OWNER-repos` was `-Users-<username>-repos`).
Public GitHub repo slugs (plugin marketplaces, upstream dotfile remotes) are kept because the configs do not work without them.

## Restoring

- `claude/` maps to `~/.claude/`.
- Rename the `projects/-Users-OWNER*` directories to match your actual home path (Claude Code derives them from the project directory, e.g. `/Users/<username>/repos` becomes `-Users-<username>-repos`).
- `home/OPINIONS.md` and `home/VOICE.md` map to `~/OPINIONS.md` and `~/VOICE.md`.
