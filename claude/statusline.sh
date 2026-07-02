#!/usr/bin/env bash
# Claude Code custom status line.
# Layout (matches the requested screenshot):
#   line 1:  model | effort | context  (context shown as usedK/totalK)
#   line 2:  folder | branch           (folder shown dotted, e.g. Docs.Devops.Internal)
#   line 3:  session id
# Reads the status JSON from stdin (see code.claude.com/docs/en/statusline).
# Targets macOS bash 3.2 (no mapfile).

input=$(cat)

# One field per line, read into an array. The while/read loop preserves empty
# lines (blank fields) and works on bash 3.2.
i=0; F=()
while IFS= read -r line; do F[i]="$line"; i=$((i+1)); done < <(printf '%s' "$input" | jq -r '
  (.model.display_name // .model.id // "?"),
  (.effort.level // ""),
  (.context_window.total_input_tokens // ""),
  (.context_window.context_window_size // ""),
  (.workspace.current_dir // .cwd // ""),
  (.session_id // "")')
model="${F[0]}" effort="${F[1]}" ctx_used="${F[2]}" ctx_size="${F[3]}" cwd="${F[4]}" session="${F[5]}"

# --- Colors: matrix-green scheme ---
MODEL=$'\033[1;38;5;46m'    # model, bold bright green
EFFORT=$'\033[1;38;5;40m'   # effort, bold medium green
DGREEN=$'\033[38;5;34m'     # folder, dim green
BRANCH=$'\033[38;5;46m'     # branch, bright green
GREEN=$'\033[38;5;46m'      # context, low usage
YELLOW=$'\033[38;5;220m'    # context, mid usage
RED=$'\033[38;5;196m'       # context, high usage
GREY=$'\033[38;5;240m'      # session
SEP=$'\033[38;5;238m | '    # separator
R=$'\033[0m'

# --- Folder: last up to 3 path components, joined with "." (e.g. Docs.Devops.Internal) ---
folder=""
if [ -n "$cwd" ]; then
  rel="$cwd"
  case "$rel" in
    "$HOME") rel="home" ;;
    "$HOME"/*) rel="${rel#"$HOME"/}" ;;
  esac
  folder=$(printf '%s' "$rel" | awk -F/ '{s=""; for(i=(NF>3?NF-2:1);i<=NF;i++) if($i!="") s=s (s==""?"":".") $i; print s}')
fi

# --- Git branch (Claude Code does not provide it; compute from cwd) ---
branch=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
  [ -z "$branch" ] && branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# --- Context: usedK/totalK, colored green->yellow->red by fill ratio ---
ctx=""
ctx_col="$GREEN"
if [ -n "$ctx_used" ] && [ "$ctx_used" != "null" ]; then
  used_k=$(( ctx_used / 1000 ))
  if [ -n "$ctx_size" ] && [ "$ctx_size" != "null" ] && [ "$ctx_size" -gt 0 ] 2>/dev/null; then
    size_k=$(( ctx_size / 1000 ))
    ctx="${used_k}K/${size_k}K"
    pct=$(( ctx_used * 100 / ctx_size ))
    if   [ "$pct" -ge 80 ]; then ctx_col="$RED"
    elif [ "$pct" -ge 50 ]; then ctx_col="$YELLOW"
    fi
  else
    ctx="${used_k}K"
  fi
fi

# --- Assemble: skip a segment cleanly when its data is missing ---
#   line 1: model | effort | context
#   line 2: folder | branch
line1="${MODEL}${model}${R}"
[ -n "$effort" ] && line1="${line1}${SEP}${EFFORT}${effort}${R}"
[ -n "$ctx" ] && line1="${line1}${SEP}${ctx_col}${ctx}${R}"

line2=""
[ -n "$folder" ] && line2="${DGREEN}${folder}${R}"
if [ -n "$branch" ]; then
  [ -n "$line2" ] && line2="${line2}${SEP}${BRANCH}⎇ ${branch}${R}" || line2="${BRANCH}⎇ ${branch}${R}"
fi

line3="${GREY}${session}${R}"

# Print; omit line 2 entirely if it has no content (keeps the bar tidy early on).
if [ -n "$line2" ]; then
  printf '%s\n%s\n%s' "$line1" "$line2" "$line3"
else
  printf '%s\n%s' "$line1" "$line3"
fi
