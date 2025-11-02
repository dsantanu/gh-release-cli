# gh-release-cli
> 🧰 A zero-dependency command-line tool to automate GitHub releases, version tagging, and changelog updates — written in pure Bash.

## 🚀 Overview

`gh-release-cli` streamlines your GitHub release process.  
It detects version metadata, validates [Semantic Versioning](https://semver.org/), manages changelogs, creates git tags, and publishes releases — all from your terminal, no CI/CD pipeline required.

It’s lightweight, portable, and works with *any* language or repository layout.

## ✨ Features

✅ Repository-agnostic — works with any project or language  
✅ Enforces **SemVer** (`vMAJOR.MINOR.PATCH`)  
✅ Detects code changes and requires version bump before release  
✅ Automatically updates **CHANGELOG.md** in place  
✅ Creates **Git tags** and publishes GitHub releases  
✅ Includes a **dry-run** mode for safe testing  
✅ Works on **macOS** and **Linux** without dependencies

## 🧠 Usage
```bash
./release.sh [options]
```
| Option                | Description                                                               |
| :-------------------- | :------------------------------------------------------------------------ |
| `-f, --file <path>`   | Target file to extract version metadata (default: first `*.sh` / `*.py`). |
| `-m, --message <msg>` | Custom commit message (default: “Release <version>”).                     |
| `-d, --dry-run`       | Preview all actions without performing any Git changes.                   |
| `-h, --help`          | Show usage help and exit.                                                 |

## 💡 Example
```bash
./release.sh --file main.py

📄 Target file: main.py
🧾 Version : v2.0.0
💬 Commit  : Release v2.0.0
🏷️  Tag Msg : main.py v2.0.0
Proceed with release? [y/N]: y
🎉 Done! Tagged v2.0.0, updated CHANGELOG, and pushed to origin.
```
## 🧰 Requirements
- Git
- GitHub CLI (gh) — optional, only required for publishing GitHub releases.

**Install on macOS or Linux:**
```bash
brew install gh     # macOS
sudo apt install gh # Ubuntu/Debian
```
## 🧾 Changelog Example
A generated changelog looks like this:

```bash
# Changelog

All notable changes will be documented in this file.

---

## v2.0.0 — 2025-11-01
- Added universal multi-language support
- Enforced version bump validation
- Integrated `--file` and `--dry-run` options
```

## 📦 Version History
See full details in [CHANGELOG.md](https://github.com/dsantanu/gh-release-cli/edit/master/README.md)

## 🧩 License
Released under the [MIT License](https://github.com/dsantanu/gh-release-cli/blob/master/LICENSE)
© 2025 Santanu Das ([@dsantanu](https://github.com/dsantanu))

## 🌟 Acknowledgements
Inspired by the AWS Cost Audit release process — now evolved into a fully universal GitHub release CLI for the DevOps community.
