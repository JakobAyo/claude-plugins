#!/usr/bin/env bash
# termshot.sh — render clean PNG/SVG screenshots of real terminal output
# using charmbracelet/freeze. Encodes one consistent "clean" styling preset
# (window chrome + rounded corners + soft shadow + padding + mono font) so
# every screenshot looks the same.
#
# Two capture modes:
#   --cmd "<command>"   Run the command in a pseudo-terminal and capture its
#                       styled output. A pty makes tty-aware programs emit
#                       ANSI color automatically. Best for short, cheap commands.
#   --file <path>       Render output you already captured to a file. Capture it
#                       first with color forced on, e.g.:
#                           FORCE_COLOR=1 your-cmd 2>&1 | tee out.ansi
#                       Best for long / expensive / already-finished runs: you can
#                       re-style without re-running the command.
#
# Examples:
#   termshot.sh --cmd "ls -la --color=always" -o ls.png
#   termshot.sh --cmd "python3 app.py --list" -o list.png --width 1100
#   FORCE_COLOR=1 ./long-run.sh 2>&1 | tee run.ansi
#   termshot.sh --file run.ansi -o run.png --width 1100 --font-size 13
set -euo pipefail

# ---- styling preset (override via flags) --------------------------------- #
OUT=""
CMD=""
FILE=""
WIDTH=""              # terminal width; raise this if long lines wrap. empty = auto
FONT="JetBrains Mono" # freeze bundles this font, so it works without a system install
FONT_SIZE="14"
LINE_HEIGHT="1.25"
BG="#11131a"
PADDING="22"
MARGIN="18"
RADIUS="8"
SHADOW_BLUR="18"
SHADOW_Y="8"
THEME=""          # optional freeze theme (mainly affects code-file syntax highlighting)
WINDOW=1          # 1 = draw macOS-style window controls

usage() { sed -n '2,28p' "$0"; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --cmd)        CMD="$2"; shift 2;;
    --file)       FILE="$2"; shift 2;;
    -o|--out)     OUT="$2"; shift 2;;
    --width)      WIDTH="$2"; shift 2;;
    --font)       FONT="$2"; shift 2;;
    --font-size)  FONT_SIZE="$2"; shift 2;;
    --line-height) LINE_HEIGHT="$2"; shift 2;;
    --bg)         BG="$2"; shift 2;;
    --padding)    PADDING="$2"; shift 2;;
    --margin)     MARGIN="$2"; shift 2;;
    --radius)     RADIUS="$2"; shift 2;;
    --theme)      THEME="$2"; shift 2;;
    --no-window)  WINDOW=0; shift;;
    -h|--help)    usage; exit 0;;
    *) echo "termshot: unknown option '$1'" >&2; usage; exit 2;;
  esac
done

# ---- validate args ------------------------------------------------------- #
if [[ -z "$OUT" ]]; then echo "termshot: -o/--out is required" >&2; exit 2; fi
if [[ -n "$CMD" && -n "$FILE" ]]; then echo "termshot: use --cmd OR --file, not both" >&2; exit 2; fi
if [[ -z "$CMD" && -z "$FILE" ]]; then echo "termshot: one of --cmd or --file is required" >&2; exit 2; fi
if [[ -n "$FILE" && ! -f "$FILE" ]]; then echo "termshot: file not found: $FILE" >&2; exit 2; fi

# ---- locate (or install) freeze ------------------------------------------ #
resolve_freeze() {
  if command -v freeze >/dev/null 2>&1; then command -v freeze; return 0; fi
  if [[ -x "$HOME/go/bin/freeze" ]]; then echo "$HOME/go/bin/freeze"; return 0; fi
  if command -v go >/dev/null 2>&1; then
    echo "termshot: freeze not found — installing via 'go install'..." >&2
    GOBIN="$HOME/go/bin" go install github.com/charmbracelet/freeze@latest >&2 || return 1
    [[ -x "$HOME/go/bin/freeze" ]] && { echo "$HOME/go/bin/freeze"; return 0; }
  fi
  return 1
}

if ! FREEZE="$(resolve_freeze)"; then
  cat >&2 <<'EOF'
termshot: could not find or install `freeze`.
Install it one of these ways, then re-run:
  go install github.com/charmbracelet/freeze@latest   # needs Go; binary lands in ~/go/bin
  brew install charmbracelet/tap/freeze               # macOS / Linuxbrew
  # or grab a release: https://github.com/charmbracelet/freeze/releases
EOF
  exit 1
fi

# ---- build freeze args (the clean preset) -------------------------------- #
args=(
  --padding "$PADDING"
  --margin "$MARGIN"
  --border.radius "$RADIUS"
  --shadow.blur "$SHADOW_BLUR" --shadow.x 0 --shadow.y "$SHADOW_Y"
  --font.family "$FONT"
  --font.size "$FONT_SIZE"
  --line-height "$LINE_HEIGHT"
  --background "$BG"
  -o "$OUT"
)
[[ "$WINDOW" -eq 1 ]] && args+=( --window )
[[ -n "$WIDTH" ]] && args+=( --width "$WIDTH" )
[[ -n "$THEME" ]] && args+=( --theme "$THEME" )

# ---- render -------------------------------------------------------------- #
mkdir -p "$(dirname "$OUT")"
if [[ -n "$CMD" ]]; then
  "$FREEZE" --execute "$CMD" "${args[@]}"
else
  # Dump the pre-captured ANSI through a pty so freeze interprets the escapes.
  printf -v catcmd 'cat -- %q' "$FILE"
  "$FREEZE" --execute "$catcmd" "${args[@]}"
fi

# ---- report -------------------------------------------------------------- #
if [[ -f "$OUT" ]]; then
  echo "termshot: wrote $OUT"
  command -v file >/dev/null 2>&1 && file "$OUT" | sed 's/^/termshot: /'
else
  echo "termshot: freeze ran but $OUT was not created" >&2
  exit 1
fi
