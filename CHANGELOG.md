# Changelog

All notable changes to **gh-release-cli.sh** will be documented in this file.
This project follows [Semantic Versioning](https://semver.org/) and maintains a single source of truth through its own automation.

---

## v2.2.1 — 2025-11-04
### ✅ Fixes
- Prevented `unbound variable` error under `set -u` when `${VERSION}` > `${LATEST_TAG}`.
- Added safe default for `${CL_MSG}` during changelog preview.
- Behavior and output remain fully backward-compatible with v2.2.0.


## v2.2.0 - 2025-11-03
### Intelligent Release Guard Edition 🧩
This release makes `gh-release` smarter, safer, and more flexible — introducing full branch awareness, version safety, and changelog intelligence.

#### ✨ Highlights
- **Branch Validation**
  - Now warns when releasing from non-`main` or `master` branches.
  - Added `-b | --branch` option to define a custom release branch.
  - Interactive confirmation before proceeding ensures accidental releases are avoided.

- **Version Regression Protection**
  - Prevents releases if the declared version (`${VERSION}`) is *lower than* the latest Git tag.
  - Displays clear error message and exits safely.

- **Duplicate Version Handling**
  - If the declared version equals the latest Git tag *and* an entry already exists in `CHANGELOG.md`,
    the new commit message is appended under that section automatically (macOS/Linux compatible).

- **Cross-Platform Safe `sed`**
  - Automatically detects OS (`uname -s`) and uses correct `sed -i` syntax for macOS (BSD) and Linux (GNU).

- **Improved Commit/Tag Logic**
  - Skips tag creation if the tag already exists (`CL_APPEND_ONLY=true`).
  - Pushes changelog updates cleanly with `git push origin HEAD`.
  - Minor edge cases in changelog prepend and file detection logic.


## v2.1.0 - 2025-11-02
### Added
- Introduced new **`header-info.txt`** file for clean metadata separation
- Added support for **Terraform files (`.tf`)** in auto-detection
- New CLI flag: `--add-all` to perform `git add -A` before commit
- Displays `Dry Run : true` status when in dry-run mode
- Renamed main script to `gh-release.sh` (simpler command name)

### Improved
- Simplified file detection logic
- Enhanced user feedback with clear visual indicators
- Maintained backward compatibility with previous version behavior

### Fixed
- Minor logic consistency improvements for `--dry-run` handling


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


## v1.1.0 — 2025-10-30
### ⚙️ Feature Additions
- Auto-generates and updates `CHANGELOG.md` entries.
- Commits `CHANGELOG` and main script in a single atomic commit.
- Introduced optional tag and commit message prompts.
- Added GitHub release creation using `gh release create`.


## v1.0.0 — 2025-10-29
### ✨ Initial Version
- Integrated with `aws-cost-audit.sh` as a local release helper.
- Added automatic tag and GitHub release creation.
- Generated initial changelog entries.
- Basic version extraction from script header.
