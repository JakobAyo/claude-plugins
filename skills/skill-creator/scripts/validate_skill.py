#!/usr/bin/env python3
"""Validate a Claude skill folder against the locked authoring conventions.

Usage:
    python3 validate_skill.py <path-to-skill-folder>

Exit code 0 = all checks pass. Non-zero = at least one error.
Checks come straight from Anthropic's Complete Guide to Building Skills;
see references/conventions.md for the rationale behind each rule.

No third-party dependencies (frontmatter is parsed manually so PyYAML
is not required).
"""
import re
import sys
from pathlib import Path

RESERVED = ("claude", "anthropic")
KEBAB = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
DESC_MAX = 1024
COMPAT_MAX = 500


def parse_frontmatter(text):
    """Return (fields_dict, error_or_None) from a SKILL.md body.

    Only top-level `key: value` lines are extracted — enough to validate
    name/description/compatibility without a full YAML parser.
    """
    if not text.startswith("---"):
        return None, 'frontmatter must start with a "---" delimiter on line 1'
    # Split on the closing delimiter (a line that is exactly ---).
    parts = re.split(r"(?m)^---\s*$", text, maxsplit=2)
    # parts[0] is empty (before first ---), parts[1] is the block, parts[2] the body.
    if len(parts) < 3:
        return None, 'frontmatter is not closed with a second "---" delimiter'
    block = parts[1]
    fields = {}
    current_key = None
    for line in block.splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        # Top-level key (no leading whitespace).
        m = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", line)
        if m and not line[0].isspace():
            current_key = m.group(1)
            fields[current_key] = m.group(2).strip()
    return fields, None


def main():
    if len(sys.argv) != 2:
        print("usage: validate_skill.py <path-to-skill-folder>")
        return 2

    folder = Path(sys.argv[1]).resolve()
    errors = []
    warnings = []

    if not folder.is_dir():
        print(f"ERROR: not a directory: {folder}")
        return 2

    name = folder.name

    # --- folder naming ---
    if not KEBAB.match(name):
        errors.append(
            f'folder name "{name}" is not kebab-case '
            "(lowercase letters, digits, single hyphens; no spaces/underscores/capitals)"
        )
    if any(r in name.lower() for r in RESERVED):
        errors.append(f'folder name "{name}" contains a reserved word ({" or ".join(RESERVED)})')

    # --- SKILL.md presence (exact case) ---
    skill_md = folder / "SKILL.md"
    listed = {p.name for p in folder.iterdir()}
    if "SKILL.md" not in listed:
        wrong = [n for n in listed if n.lower() == "skill.md"]
        if wrong:
            errors.append(f'main file must be exactly "SKILL.md" (found "{wrong[0]}")')
        else:
            errors.append("missing required SKILL.md")
        # Cannot validate frontmatter without the file.
        return report(errors, warnings)

    # --- no README.md inside the skill folder ---
    if any(n.lower() == "readme.md" for n in listed):
        errors.append("README.md must not live inside the skill folder (use SKILL.md or references/)")

    # --- frontmatter ---
    text = skill_md.read_text(encoding="utf-8")
    fields, fm_err = parse_frontmatter(text)
    if fm_err:
        errors.append(f"frontmatter: {fm_err}")
        return report(errors, warnings)

    # name field
    fname = fields.get("name")
    if not fname:
        errors.append('frontmatter is missing required field "name"')
    else:
        if not KEBAB.match(fname):
            errors.append(f'name "{fname}" is not kebab-case')
        if fname != name:
            warnings.append(f'name "{fname}" does not match folder name "{name}"')
        if any(r in fname.lower() for r in RESERVED):
            errors.append(f'name "{fname}" contains a reserved word ({" or ".join(RESERVED)})')

    # description field
    desc = fields.get("description")
    if not desc:
        errors.append('frontmatter is missing required field "description"')
    else:
        if len(desc) > DESC_MAX:
            errors.append(f"description is {len(desc)} chars (limit {DESC_MAX})")
        if "<" in desc or ">" in desc:
            errors.append("description contains forbidden XML angle brackets (< or >)")
        if not re.search(r"\b(use when|use for|use if|when the user|when user)\b", desc, re.I):
            warnings.append('description should state WHEN to use the skill (e.g. "Use when ...")')

    # compatibility (optional) length
    compat = fields.get("compatibility")
    if compat and len(compat) > COMPAT_MAX:
        errors.append(f"compatibility is {len(compat)} chars (limit {COMPAT_MAX})")

    # XML brackets anywhere in the frontmatter block
    block = re.split(r"(?m)^---\s*$", text, maxsplit=2)[1]
    if "<" in block or ">" in block:
        errors.append("frontmatter contains XML angle brackets (< or >) — forbidden")

    return report(errors, warnings)


def report(errors, warnings):
    for w in warnings:
        print(f"WARN:  {w}")
    for e in errors:
        print(f"ERROR: {e}")
    if errors:
        print(f"\nFAILED: {len(errors)} error(s), {len(warnings)} warning(s)")
        return 1
    print(f"OK: skill is valid ({len(warnings)} warning(s))")
    return 0


if __name__ == "__main__":
    sys.exit(main())
