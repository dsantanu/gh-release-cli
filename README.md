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
| Option                | Description                                            |
| --------------------- | ------------------------------------------------------ |
| `-f, --file <path>`   | File to find release info (default: `header-info.txt`) |
| `-m, --message <msg>` | Commit message (default: `"Release <version>"`)        |
| `-a, --add-all`       | Add all changes with `git add -A` before committing    |
| `-d, --dry-run`       | Show actions without making changes                    |
| `-h, --help`          | Show help and exit                                     |
```

## 💡 Example
**Simulate a Release**
```bash
./gh-release.sh \
  --file header-info.txt \
  --message "Release v2.1.0 – header file logic and add-all option" \
  --dry-run
```

**Create an Actual Release**
```
./gh-release.sh \
  --file header-info.txt \
  --message "Release v2.1.0 – header file logic and add-all option" \
  --add-all
```
📄 Target file: main.py
🧾 Version : v2.0.0
💬 Commit  : Release v2.0.0
🏷️ Tag Msg : main.py v2.0.0
Proceed with release? [Y/N]: y
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

## ⚙️ Installation
**Clone and make executable:**

```bash
git clone https://github.com/dsantanu/gh-release-cli.git
cd gh-release-cli
chmod +x gh-release-cli
```
**Glabal Install**
```bash
sudo curl -fsSL https://raw.githubusercontent.com/dsantanu/gh-release-cli/main/gh-release-cli.sh \
          -o /usr/local/bin/gh-release-cli && sudo chmod +x /usr/local/bin/gh-release-cli
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
Inspired by the [AWS Cost Audit](https://github.com/dsantanu/aws-cost-audit) release process — now evolved into a fully universal GitHub release CLI for the DevOps community.
