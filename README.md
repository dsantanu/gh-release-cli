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

