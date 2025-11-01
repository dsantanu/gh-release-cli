# gh-release-cli
> 🧰 A zero-dependency command-line tool to automate GitHub releases, version tagging, and changelog updates — written in pure Bash.

---

## 🚀 Overview

`gh-release-cli` streamlines your GitHub release process.  
It detects version metadata, validates [Semantic Versioning](https://semver.org/), manages changelogs, creates git tags, and publishes releases — all from your terminal, no CI/CD pipeline required.

It’s lightweight, portable, and works with *any* language or repository layout.

---

## ✨ Features

✅ Repository-agnostic — works with any project or language  
✅ Enforces **SemVer** (`vMAJOR.MINOR.PATCH`)  
✅ Detects code changes and requires version bump before release  
✅ Automatically updates **CHANGELOG.md** in place  
✅ Creates **Git tags** and publishes GitHub releases  
✅ Includes a **dry-run** mode for safe testing  
✅ Works on **macOS** and **Linux** without dependencies

---

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

---
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

