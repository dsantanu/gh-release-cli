# Changelog

All notable changes to **gh-release-cli.sh** will be documented in this file.
This project follows [Semantic Versioning](https://semver.org/) and maintains a single source of truth through its own automation.

---

## v2.0.0 — 2025-11-01
### 🚀 Major Release — Universal GitHub Release Tool
- Made it **repository-agnostic** — works with any language or project.
- Added CLI options:
  - `--file/-f` to target specific file (default auto-detects main script).
  - `--message/-m` for custom commit message.
  - `--dry-run/-d` for preview without any Git actions.
  - `--help/-h` for usage guide.
- Added automatic metadata extraction (`# Name`, `# Author`, `# Version`) if available.
- Implemented **SemVer validation** (`vMAJOR.MINOR.PATCH` format).
- Added **change detection guard** — prevents release if file modified but version not bumped.
- Reworked CHANGELOG logic:
  - Preserves top description header.
  - Inserts new release entries below header.
- Added optional GitHub release publishing via `gh`.
- Cross-platform support for macOS and Linux.
- Updated README

## v1.2.0 — 2025-10-31
### 🔒 Stability & Safety
- Added **SemVer format validator**.
- Added **branch safety check** to prevent accidental non-`main` releases.
- Added `git diff`-based change detection to enforce version bump before release.

---

## v1.1.0 — 2025-10-30
### ⚙️ Feature Additions
- Auto-generates and updates `CHANGELOG.md` entries.
- Commits `CHANGELOG` and main script in a single atomic commit.
- Introduced optional tag and commit message prompts.
- Added GitHub release creation using `gh release create`.

---

## v1.0.0 — 2025-10-29
### ✨ Initial Version
- Integrated with `aws-cost-audit.sh` as a local release helper.
- Added automatic tag and GitHub release creation.
- Generated initial changelog entries.
- Basic version extraction from script header.
