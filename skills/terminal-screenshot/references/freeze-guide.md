# freeze guide — capturing and styling terminal screenshots

Deep reference for the `terminal-screenshot` skill. Read this when you need to go
beyond the `termshot.sh` defaults: a different look, a tricky color case, or to
drive `freeze` directly.

## What freeze is

[`freeze`](https://github.com/charmbracelet/freeze) renders text — either a source
file (with syntax highlighting) or the **output of a command** — into an image
(`.png`, `.svg`, `.webp`). It needs **no display, browser, or X/Wayland session**,
so it works in headless shells and CI. That is why it beats screen-grabbers
(`grim`/`scrot`/`import`) for terminal output: those capture whatever is on a
physical screen; freeze renders the bytes directly and crisply.

Install:

```bash
go install github.com/charmbracelet/freeze@latest   # → ~/go/bin/freeze
brew install charmbracelet/tap/freeze               # macOS / Linuxbrew
# or a prebuilt binary from the GitHub releases page
```

## The two capture modes (and why)

### Mode A — `--execute` (pseudo-terminal)

```bash
freeze --execute "git status" -o out.png
```

`--execute` runs the command attached to a **pseudo-terminal (pty)**. Because a
pty *is* a tty, programs that gate color on `isatty()` (git, ls, most modern CLIs)
emit their ANSI color automatically — no extra flags. Best for short, cheap,
deterministic commands.

`termshot.sh --cmd "<command>"` wraps this mode.

### Mode B — pre-captured file

```bash
FORCE_COLOR=1 ./long-task.sh 2>&1 | tee out.ansi   # capture once
freeze --execute "cat out.ansi" -o out.png          # render (and re-render) freely
```

Capture the output to a file with color forced on, then render the file. Two big
wins:

1. **Decouples an expensive run from rendering.** Run the slow/costly command
   *once*; restyle the image as many times as you like (change width, font, theme)
   without paying for the command again. This matters a lot for runs that call
   paid APIs, hit the network, or take minutes.
2. **Captures programs that respect `FORCE_COLOR`** even though their output is a
   pipe, not a tty.

`termshot.sh --file <path>` wraps this mode (it renders the file through a pty via
`cat` so the escape codes are interpreted).

## Forcing color: FORCE_COLOR vs NO_COLOR

Most well-behaved CLIs follow these conventions:

| Variable | Effect |
|----------|--------|
| `FORCE_COLOR=1` | Emit ANSI color even when stdout is not a tty (i.e. when piped). |
| `NO_COLOR=1` | Suppress all color, even on a tty. |
| `--color=always` | Tool-specific flag with the same intent as `FORCE_COLOR` (ls, git, grep, rg, ...). |

If Mode B produces a grey image, the program probably ignores `FORCE_COLOR`; reach
for its `--color=always` flag, or switch to Mode A so it sees a real tty.

## The clean preset (what makes it look good)

`termshot.sh` applies this set. Tweak via its flags, or pass straight to freeze:

| freeze flag | Preset value | Effect |
|-------------|--------------|--------|
| `--window` | on | macOS-style red/yellow/green window controls. |
| `--border.radius` | `8` | Rounded window corners. |
| `--margin` | `18` | Transparent space around the window (room for the shadow). |
| `--padding` | `22` | Space between the window edge and the text. |
| `--shadow.blur` / `--shadow.x` / `--shadow.y` | `18` / `0` / `8` | Soft drop shadow below the window. |
| `--font.family` | `JetBrains Mono` | Bundled with freeze, so it renders even without a system install. |
| `--font.size` | `14` | Readable; drop to `13` to fit wider output. |
| `--line-height` | `1.25` | A little breathing room between lines. |
| `--background` | `#11131a` | Dark, slightly blue. |
| `--width` | (unset) | Terminal width. Leave auto for short output; set `1100`+ to stop long lines wrapping. |
| `-o` | required | Output file; extension picks the format (`.png`/`.svg`/`.webp`). |

### Sizing and wrapping

`--width` is the single most common knob to adjust. Output auto-sizes its height to
the content, but width is fixed: if the longest line is wider than the terminal,
it wraps (or appears clipped). Raise `--width` until nothing wraps. SVG output
(`-o out.svg`) stays crisp at any zoom and is a good choice for docs that scale.

## Alternate looks

```bash
# Light theme
termshot.sh --cmd "ls --color=always" -o out.png --bg "#fafafa" --font-size 14

# No window chrome (flat, for embedding)
termshot.sh --cmd "neofetch" -o out.png --no-window

# Vector output for high-DPI docs
termshot.sh --cmd "make test" -o out.svg

# Source-file screenshot (no execution) — drive freeze directly, not this skill:
freeze main.py --window --theme dracula -o code.png
```

freeze ships many syntax themes (`--theme dracula`, `nord`, `github`, ...); themes
mainly affect source-file highlighting and matter less for raw ANSI output, where
the program's own colors are used.

## Verifying the result

Always look at the image before declaring success:

- **In an agent/tool context:** read the PNG back so you actually see it.
- **Interactively:** `xdg-open out.png` (Linux) / `open out.png` (macOS).
- **Quick metadata check:** `file out.png` prints the pixel dimensions — a sanity
  check that it rendered and isn't 0-sized.

Check for: color present, no wrapped/clipped lines, the bottom not cut off, and the
window chrome intact.
