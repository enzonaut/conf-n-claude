# conf-n-claude

Scrubbed backup of my Claude Code setup.

## Layout

- `claude/` - mirror of `~/.claude`: `CLAUDE.md`, `settings.json`, `settings.local.json`, `statusline.sh`, and per-project memory under `projects/*/memory/`.
- `home/` - `OPINIONS.md` and `VOICE.md`, which live at `~` and are read by agents via `claude/CLAUDE.md`.
- `config/` - mirror of `~/.config`: `herdr/config.toml` + `herdr/scripts/` (the terminal workspace manager) and `ghostty/config` (the terminal engine, whose Cmd-chord keybinds fire herdr's prefix shortcuts).

## Keybindings

herdr's prefix is **Ctrl+Space** (`\x00`). Ghostty is configured to fire herdr shortcuts in one press: each `Cmd` chord sends `prefix + key` as raw text, so it acts instantly with no visible prefix step. Bare `Ctrl` chords are passed straight through to herdr's direct (no-prefix) indexed bindings.

Three ways to reach the number row:

| Chord | Jumps to | Wired by |
| --- | --- | --- |
| **Cmd+1..9** | space (workspace) | ghostty `\x00`+digit -> herdr `switch_workspace = prefix+1..9` |
| **Ctrl+1..9** | agent (priority-sorted) | herdr `[keys.indexed] agents = "ctrl"` |
| **Ctrl+Shift+1..9** | tab | herdr `[keys.indexed] tabs = "ctrl+shift"` |

### Cmd shortcuts (ghostty -> herdr, single press)

| Chord | Action | Sends | herdr binding |
| --- | --- | --- | --- |
| Cmd+N | New space | `\x00N` | `new_workspace` (prefix+shift+n) |
| Cmd+T | New tab in space | `\x00c` | `new_tab` (prefix+c) |
| Cmd+D | New pane, side-by-side | `\x00v` | `split_vertical` (prefix+v) |
| Cmd+Shift+D | New pane, top/bottom | `\x00-` | `split_horizontal` (prefix+minus) |
| Cmd+W | Close pane | `\x00x` | `close_pane` (prefix+x) |
| Cmd+Shift+R | Rename current space | `\x00W` | `rename_workspace` (prefix+shift+w) |
| Cmd+Shift+A | Next agent | `\x00a` | `next_agent` (prefix+a) |
| Cmd+/ | Help cheat-sheet | `\x00H` | `help` (prefix+shift+h) |
| Cmd+1..9 | Switch to space 1..9 | `\x00`+digit | `switch_workspace` (prefix+1..9) |
| Cmd+Opt+←/↓/↑/→ | Focus pane left/down/up/right | `\x00h/j/k/l` | `focus_pane_*` (prefix+h/j/k/l) |
| Cmd+V | Paste into Claude Code | `\x16` (raw Ctrl+V) | — (Claude reads clipboard: text or image) |
| Cmd+Shift+V | Plain terminal paste | — | ghostty `paste_from_clipboard` |
| Shift+Enter | Newline for Claude CLI | `\x1b\r` | — |

### herdr prefix bindings (Ctrl+Space, then key)

Customized in `config.toml`:

| Chord | Action |
| --- | --- |
| prefix, Shift+H | Help popup |
| prefix, Shift+J / Shift+K | Next / previous space |
| prefix, 1..9 | Switch to space |
| prefix, Shift+1..9 | Switch to tab |
| prefix, A / Shift+A | Next / previous agent |
| prefix, ` (backtick) | Last pane |
| prefix, Shift+O / Shift+E | Open / remove worktree |
| prefix, Shift+L | lazygit in a throwaway pane |
| prefix, Shift+C | Live clock in a throwaway pane |
| prefix, Shift+V | Scrollback in floating nvim |

Relied-on herdr defaults (not overridden):

| Chord | Action |
| --- | --- |
| prefix, C | New tab |
| prefix, N / P | Next / previous tab |
| prefix, Shift+N | New space |
| prefix, Shift+G | New worktree |
| prefix, V / minus | Split pane vertical / horizontal |
| prefix, X / Shift+X | Close pane / close tab |
| prefix, H/J/K/L | Focus pane by direction |
| prefix, Tab / Shift+Tab | Cycle pane next / previous |
| prefix, Shift+W | Rename space |
| prefix, Shift+T | Rename tab |
| prefix, Shift+P | Rename pane |
| prefix, Z | Zoom pane |
| prefix, R | Resize mode |
| prefix, B | Toggle sidebar |
| prefix, W | Workspace picker |
| prefix, G | Goto navigator |
| prefix, E | Edit scrollback |
| prefix, O | Open notification target |
| prefix, S | Settings |
| prefix, Q | Detach |
| prefix, Shift+R | Reload config |

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
- `config/` maps to `~/.config/` (`config/herdr/` -> `~/.config/herdr/`, `config/ghostty/` -> `~/.config/ghostty/`). Restore the `OWNER` paths in `herdr/config.toml` back to your username.
