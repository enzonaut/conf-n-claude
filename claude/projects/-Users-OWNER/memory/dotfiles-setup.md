---
name: dotfiles-setup
description: "User's dotfiles are ryanthedev/dot-config cloned into ~/.config; how it's wired and backed up"
metadata: 
  node_type: memory
  type: project
  originSessionId: d1200958-fe5e-4713-babc-bfb1b730f6dd
---

The user installed the **ryanthedev/dot-config** dotfiles (core dev stack only — no window manager) on a fresh macOS (Apple Silicon, macOS 26.5).

- The repo IS `~/.config` (git repo, remote `origin` = github.com/ryanthedev/dot-config, branch main). Their pre-existing `~/.config/gh` was preserved (untracked).
- Pre-install dotfiles snapshot committed to git repo at `~/repos/old-dotconfig-backup`.
- Home symlinks: `~/.zshrc` -> `~/.config/zsh/.zshrc`, `~/.p10k.zsh` -> `~/.config/zsh/.p10k.zsh`. Also `~/.local/bin/mise` -> brew mise, and `~/.fzf.zsh` generated via `fzf --zsh`.
- Installed via brew: neovim, tmux, fzf, zoxide, ripgrep, mise, ghostty (cask), font-meslo-lg-nerd-font. Plus oh-my-zsh, powerlevel10k + zsh-syntax-highlighting in omz custom, TPM with 6 tmux plugins.
- nvim = lazy.nvim, config under `~/.config/nvim/lua/rtd/`. tmux prefix is **C-Space**.
- Skipped Linux-only configs (i3, polybar, rofi, dalauncher) and the macOS WM stack (theGrid, sketchybar).

**Known local change:** ghostty `font-family` was changed from "BerkeleyMono Nerd Font" (paid, not owned) to "MesloLGS Nerd Font". Original line kept commented.

**Terminal:** user prefers **cmux** (manaflow-ai/cmux, installed via `brew tap manaflow-ai/cmux && brew install --cask cmux`) over Ghostty — "got too used to it". cmux is a libghostty-based macOS terminal for AI agents (NOT a tmux replacement). It READS `~/.config/ghostty/config` for font/theme/colors, so the matrix theme carries over automatically. cmux-only chrome is in `~/.config/cmux/cmux.json` (set: sidebarAppearance.matchTerminalBackground=true, workspaceColors selection/badge = matrix greens). `cmux reload-config` reloads both files live. Both cmux and Ghostty are installed; user can use either.

The user wants to LEARN these tools (nvim, tmux, zsh/p10k, fzf, zoxide), so favor explanation over just doing.
