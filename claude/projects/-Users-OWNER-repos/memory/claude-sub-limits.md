---
name: claude-sub-limits
description: "OWNER's Claude sub has no monthly token cap — 5h + 7-day rolling windows via the OAuth usage endpoint; extra_usage disabled"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 503e9ebb-9f6c-4ffb-9cb0-4c5429936018
---

Verified 2026-07-01 against `https://api.anthropic.com/api/oauth/usage` (undocumented; Bearer token from macOS keychain item "Claude Code-credentials", header `anthropic-beta: oauth-2025-04-20`):

- No monthly token/dollar cap. Limits are `five_hour` and `seven_day` rolling windows; `utilization` is already in percent units. Also a model-scoped weekly limit (Fable).
- `extra_usage` (the "Quota: $X of $Y" seen in shared statusline examples) is **disabled** on his account — all null.
- `cost.total_cost_usd` in the statusline JSON is a per-session API-price estimate, not sub billing.
- His statusline is `~/.claude/statusline.sh` (matrix-green, bash 3.2 compatible).
