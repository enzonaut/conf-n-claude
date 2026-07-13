#!/usr/bin/env bash
# Regenerate the scrubbed mirror in this repo from the live files.
#
# Scrubbed identifiers:
#   - the machine username (basename of $HOME) in path forms: /Users/<u>, -Users-<u>
#   - the owner handle (git config user.name, falling back to the origin repo owner)
#   - the git user.email
#   - any extra literals listed in .scrub-extra (gitignored, one per line;
#     lines containing "@" become owner@example.com, everything else OWNER)
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"

USERNAME="$(basename "$HOME")"
HANDLE="$(git -C "$REPO" config --get user.name || true)"
[ -n "$HANDLE" ] || HANDLE="$(git -C "$REPO" remote get-url origin | sed -E 's#.*[:/]([^/]+)/[^/]+$#\1#')"
EMAIL="$(git -C "$REPO" config --get user.email || true)"

rm -rf "$REPO/claude" "$REPO/home" "$REPO/config"
mkdir -p "$REPO/claude" "$REPO/home" \
   "$REPO/config/herdr/scripts" "$REPO/config/ghostty"

cp "$HOME/.claude/CLAUDE.md" "$HOME/.claude/settings.json" \
   "$HOME/.claude/settings.local.json" "$HOME/.claude/statusline.sh" \
   "$REPO/claude/"
cp "$HOME/OPINIONS.md" "$HOME/VOICE.md" "$REPO/home/"

# ~/.config mirror — herdr (terminal workspace manager) reads config.toml and the
# referenced helper scripts; ghostty (terminal engine) reads its config for the
# cmd-chord -> herdr-prefix keybinds.
cp "$HOME/.config/herdr/config.toml" "$REPO/config/herdr/"
cp "$HOME/.config/herdr/scripts/"* "$REPO/config/herdr/scripts/"
cp "$HOME/.config/ghostty/config" "$REPO/config/ghostty/"

for d in "$HOME"/.claude/projects/*/memory; do
  proj="$(basename "$(dirname "$d")")"
  scrubbed="${proj//-Users-$USERNAME/-Users-OWNER}"
  mkdir -p "$REPO/claude/projects/$scrubbed/memory"
  cp "$d"/* "$REPO/claude/projects/$scrubbed/memory/"
done

scrub() { # scrub <literal> <replacement>
  find "$REPO/claude" "$REPO/home" "$REPO/config" -type f -exec perl -pi -e \
    "s{\Q$1\E}{$2}g" {} +
}

[ -n "$EMAIL" ] && scrub "$EMAIL" "owner\@example.com"
scrub "$HANDLE" "OWNER"
scrub "/Users/$USERNAME" "/Users/OWNER"
scrub "-Users-$USERNAME" "-Users-OWNER"
if [ -f "$REPO/.scrub-extra" ]; then
  while IFS= read -r literal; do
    [ -n "$literal" ] || continue
    case "$literal" in
      *@*) scrub "$literal" "owner\@example.com" ;;
      *)   scrub "$literal" "OWNER" ;;
    esac
  done < "$REPO/.scrub-extra"
fi

leftovers="$(grep -rnF -e "$HANDLE" -e "/Users/$USERNAME" -e "-Users-$USERNAME" \
  ${EMAIL:+-e "$EMAIL"} "$REPO/claude" "$REPO/home" "$REPO/config" || true)"
if [ -n "$leftovers" ]; then
  echo "ERROR: identifiers survived the scrub:" >&2
  echo "$leftovers" >&2
  exit 1
fi
echo "Mirror refreshed and scrub verified clean."
