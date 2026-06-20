---
name: terminal-screenshot
description: Render clean, polished screenshots of real terminal output as PNG or SVG using charmbracelet/freeze. Captures genuine ANSI color (via a pseudo-terminal or the FORCE_COLOR variable) and applies one consistent style — window chrome, rounded corners, soft shadow, padding, and a monospace font. Use when the user asks to screenshot the terminal, turn CLI or command output into an image, make a terminal screenshot for a README or docs, render colored shell output as a PNG or SVG, or "freeze" terminal output. Works for any command-line program.
metadata:
  author: Jakob
  version: 1.0.0
compatibility: Needs the `freeze` binary (charmbracelet/freeze). The bundled script auto-installs it via `go install` when Go is available; otherwise install freeze manually (brew or a GitHub release). Rendering needs no display or browser.
---

# Terminal Screenshot

Produce crisp, consistent image files of **real** terminal output — the kind that
look great in a README, a slide, or a bug report. The look (window controls,
rounded corners, soft drop shadow, generous padding, JetBrains Mono, dark
background) is encoded once in `scripts/termshot.sh` so every screenshot matches.

The engine is [charmbracelet/freeze](https://github.com/charmbracelet/freeze):
it renders text/ANSI to PNG, SVG, or WebP with no browser and no display needed.

## When to invoke

- User says: "screenshot the terminal", "make a terminal screenshot", "turn this
  command output into an image", "render this CLI output as a PNG/SVG", "add a
  terminal screenshot to the README", "freeze this output".
- The user wants an image of how a command-line program *looks* when it runs.

Do **not** invoke for:
- Screenshots of a GUI window or the whole desktop — that needs a real
  screen-grabber (`grim`, `scrot`, `import`), not this skill.
- Syntax-highlighted images of a **source file** with no execution — `freeze
  file.py -o out.png` does that directly; this skill is for *command output*.

## Important

- **Capture real output. Never fabricate a screenshot.** The whole value is that
  the image shows what actually happened. Run the command (or render output you
  genuinely captured); do not hand-write fake terminal text.
- **Pick the capture mode by cost:**
  - `--cmd "<command>"` runs the command inside a pseudo-terminal, so tty-aware
    programs emit color automatically. Use it for short, cheap, repeatable commands.
  - `--file <path>` renders output you saved earlier. Capture it with color forced
    on (`FORCE_COLOR=1 your-cmd 2>&1 | tee out.ansi`). Use it for **long or
    expensive runs** (anything that costs money, hits the network, or takes minutes)
    so you can re-style the image without re-running the command.
- **Always verify the result by viewing it.** After rendering, open/read the image
  and check it for wrapped lines, missing color, or a cut-off bottom. Don't report
  done on an image you haven't looked at.
- **For READMEs, commit the image into the repo** and reference it with a
  repo-relative path (e.g. `docs/screenshots/run.png`) so it renders on GitHub.

## Inputs

Before rendering, settle:
1. **What to capture** — the exact command, or the path to already-captured output.
2. **Output path** — `.png` (default choice), `.svg` (crisp at any zoom), or `.webp`.
3. **Where it's used** — a README/docs in a repo means commit the file and use a
   relative path. A one-off can go in a scratch dir.

Defaults are sensible; only ask the user if the command itself or its destination
is genuinely unclear.

## Workflow

1. **Capture the output.**
   - Short/cheap command → skip ahead and let `--cmd` run it.
   - Long/expensive/already-run → capture to a file first:
     ```bash
     FORCE_COLOR=1 <your-command> 2>&1 | tee /tmp/out.ansi
     ```
2. **Render with the preset.** The script finds (or installs) `freeze` and applies
   the clean style:
   ```bash
   # mode A — run it now
   bash scripts/termshot.sh --cmd "<command>" -o <out.png>

   # mode B — render captured output
   bash scripts/termshot.sh --file /tmp/out.ansi -o <out.png>
   ```
   Add `--width 1100` (or higher) when output has long lines — see Troubleshooting.
   On success it prints `termshot: wrote <path>` and the image dimensions.
3. **Verify.** View the image (read the PNG, or `xdg-open`/`open` it) and confirm:
   color is present, no lines wrapped awkwardly, nothing is cut off at the bottom.
4. **Place & report.** For docs, move/save the image into the repo (e.g.
   `docs/screenshots/`) and embed it (`![alt](docs/screenshots/run.png)`). Tell the
   user the final path and that it was rendered from real output.

See `references/freeze-guide.md` for the full flag set, color-forcing details, and
preset-tuning tips.

## Examples

### Example 1: a CLI run for a README

User says: "Add a screenshot of `python3 harness.py --list` to the README."

Actions:
1. `bash scripts/termshot.sh --cmd "python3 harness.py --list" -o docs/screenshots/list.png`
2. Read `docs/screenshots/list.png` to confirm it looks clean.
3. Add `![harness --list](docs/screenshots/list.png)` to the README and tell the
   user to commit `docs/` so GitHub renders it.

Result: a polished, repo-relative screenshot of the actual command output.

### Example 2: a long, expensive run

User says: "Screenshot the whole agent run."

Actions:
1. `FORCE_COLOR=1 ./run-agents.sh 2>&1 | tee /tmp/run.ansi` (run once; it's slow).
2. `bash scripts/termshot.sh --file /tmp/run.ansi -o docs/screenshots/run.png --width 1100`
3. If a line wrapped, bump `--width` and re-render — no need to re-run the agent.
4. Verify and report.

## Troubleshooting

### Output has no color (everything is grey)
**Cause:** The program suppressed color because it didn't detect a terminal.
**Solution:** Use `--cmd` (the pty turns color on), or capture with `FORCE_COLOR=1`
set. Some tools instead honor `--color=always` (e.g. `ls`, `git`, `grep`).

### Long lines wrap or get cut off on the right
**Cause:** The virtual terminal is narrower than the content.
**Solution:** Pass `--width 1100` (or wider). Re-render with `--file` mode so you
don't repeat the command. Lowering `--font-size` (e.g. `13`) also helps fit.

### `freeze: command not found` / install failed
**Cause:** `freeze` isn't installed and `go` isn't available to auto-install it.
**Solution:** Install manually — `brew install charmbracelet/tap/freeze`, or
download a release from the freeze GitHub releases page, then re-run.

### The image is enormous or the bottom is clipped
**Cause:** Very long output makes a very tall image; that's expected.
**Solution:** Capture just the relevant slice (e.g. pipe through `tail`/`sed`
before `tee`), or render the final summary separately. Height auto-sizes to content.

### Font looks wrong
**Cause:** A requested `--font` family isn't available.
**Solution:** Omit `--font` (freeze bundles JetBrains Mono) or pass a family you
have installed (check with `fc-list`).

## References

- `references/freeze-guide.md` — full freeze flag reference, the two capture modes
  in depth, FORCE_COLOR / NO_COLOR semantics, styling-preset rationale, and
  alternate looks (light theme, no-window, SVG).
- `scripts/termshot.sh` — the wrapper that locates/installs freeze and applies the
  clean preset. Run with `--help` for its options.
