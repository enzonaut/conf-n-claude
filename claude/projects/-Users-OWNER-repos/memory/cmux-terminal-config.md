---
name: cmux-terminal-config
description: "cmux uses Ghostty as its terminal engine and reads ~/.config/ghostty/config for font size, theme, colors, keybinds"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 70d7c799-6ce8-4e5e-b519-ba1cc34e688d
---

The user runs **cmux** (cmux.app, bundle id `com.cmuxterm.app`) as their Claude Code GUI. cmux embeds **Ghostty** as its terminal engine and reads the standard `~/.config/ghostty/config` for terminal settings (font, theme, colors, keybinds) — NOT the empty `~/Library/Application Support/com.cmuxterm.app/config.ghostty`.

- Default terminal **font size** is set by `font-size = N` in `~/.config/ghostty/config`. Cmd+- / Cmd+= only zoom per-session and reset on new sessions; changing this line changes the default for all new sessions. (Set to 14 on 2026-06-29, down from 20.)
- Apply changes: reload with Cmd+Shift+, in an open session, or quit/reopen cmux.
- cmux's own (non-terminal) settings live in `~/.config/cmux/cmux.json` (sidebar appearance, workspace colors) and macOS prefs `defaults read com.cmuxterm.app`.
- Active theme is a custom monochromatic-green "Matrix" theme; font is "MesloLGS Nerd Font".
