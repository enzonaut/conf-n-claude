---
name: dotfiles-setup
description: "User's dotfiles are ryanthedev/dot-config cloned into ~/.config; how it's wired and backed up"
metadata: 
  node_type: memory
  type: project
  originSessionId: d1200958-fe5e-4713-babc-bfb1b730f6dd
---

The user installed the **ryanthedev/dot-config** dotfiles (core dev stack only — no window manager) on a fresh macOS (Apple Silicon, macOS 26.5).

- The repo lives at `~/repos/dot-config` (remote `origin` = github.com/ryanthedev/dot-config, branch main); `~/.config` is a symlink to it (moved 2026-07-12; it used to BE the repo). Their pre-existing `~/.config/gh` was preserved (untracked).
- Separate repo `~/repos/conf-n-claude` (remote OWNER/conf-n-claude) = scrubbed manual backup of `~/.claude` + `~/OPINIONS.md`/`~/VOICE.md` (identifiers replaced with OWNER placeholders). NOT linked to dot-config; refreshed only by manual re-scrub.
- Pre-install dotfiles snapshot committed to git repo at `~/repos/old-dotconfig-backup`.
- Home symlinks: `~/.zshrc` -> `~/.config/zsh/.zshrc`, `~/.p10k.zsh` -> `~/.config/zsh/.p10k.zsh`. Also `~/.local/bin/mise` -> brew mise, and `~/.fzf.zsh` generated via `fzf --zsh`.
- Installed via brew: neovim, tmux, fzf, zoxide, ripgrep, mise, ghostty (cask), font-meslo-lg-nerd-font. Plus oh-my-zsh, powerlevel10k + zsh-syntax-highlighting in omz custom, TPM with 6 tmux plugins.
- nvim = lazy.nvim, config under `~/.config/nvim/lua/rtd/`. tmux prefix is **C-Space**.
- Skipped Linux-only configs (i3, polybar, rofi, dalauncher) and the macOS WM stack (theGrid, sketchybar).

**Known local change:** ghostty `font-family` was changed from "BerkeleyMono Nerd Font" (paid, not owned) to "MesloLGS Nerd Font". Original line kept commented.

**Terminal (as of 2026-07-12):** user now runs **herdr** (brew formula, AGPL, herdr.dev - an agent multiplexer TUI, client/server like tmux) inside **Ghostty**. herdr config: `~/.config/herdr/config.toml` (prefix ctrl+space, tokyo-night theme, priority agent sort, ctrl+1..9 agent jump); reload with `herdr server reload-config`. Ghostty config: font Hack Nerd Font Mono 16 (was 20, reduced 2026-07-12), Tokyo Night theme, `super+v=text:\x16` so Cmd+V reaches Claude Code's ctrl+v clipboard handler (text+images; verified CC's ctrl+v pastes text too), Cmd+Shift+V = plain terminal paste. User previously used cmux (manaflow-ai/cmux, libghostty-based native app) and liked its cmd-key ergonomics; wants herdr bindings to converge on cmux habits - since herdr is a TUI, cmd-keys must be translated via ghostty `keybind = super+X=text:...` lines.

The user wants to LEARN these tools (nvim, tmux, zsh/p10k, fzf, zoxide), so favor explanation over just doing.
