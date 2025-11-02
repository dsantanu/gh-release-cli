#!/usr/bin/env bash
# ==========================================================
# gh-release-cli.sh — Automated GitHub release helper
# Author : Santanu Das (@dsantanu)  |  License: MIT
# Version: v1.2.0
# Desc   : Extract metadata, enforce version bump, prepend
#          CHANGELOG, create tag and GitHub release (via gh)
# ==========================================================
set -euo pipefail

SCRIPT="aws-cost-audit.sh"
CHANGELOG="CHANGELOG.md"
GITBRANCH="main"

# --- Metadata from script header -------------------------------------
NAME=$(awk -F':' '/^# Name/    {print $2}' "${SCRIPT}" | xargs)
AUTHOR=$(awk -F':' '/^# Author/  {print $2}' "${SCRIPT}" | xargs)
VERSION=$(awk -F':' '/^# Version/ {print $2}' "${SCRIPT}" | xargs)
DESC=$(awk -F':' '/^# Desc/     {print $2}' "${SCRIPT}" | xargs)

if [[ -z "${VERSION}" ]]; then
  echo "❌ VERSION not found in script header (expected line: '#  Version: vX.Y.Z')"
  exit 1
fi

# --- Guard: detect script changes without version bump ----------------
# If aws-cost-audit.sh has changes (staged or unstaged) AND the current header
# VERSION already exists as a tag, we must bump Version before releasing.
LATEST_TAG=$(git tag --sort=-v:refname | head -n1 || true)

SCRIPT_CHANGED=false
git diff --name-only -- "${SCRIPT}" | grep -q "^${SCRIPT}$" && SCRIPT_CHANGED=true
git diff --cached --name-only -- "${SCRIPT}" | grep -q "^${SCRIPT}$" && SCRIPT_CHANGED=true

if [[ "${SCRIPT_CHANGED}" == true && "${VERSION}" == "${LATEST_TAG}" ]]; then
  echo "⛔ Detected changes in ${SCRIPT} but Version header is still '${VERSION}'."
  echo "   Bump the header version in ${SCRIPT} (e.g., to vX.Y.Z) and re-run release."
  exit 1
fi

# Optional: ensure we’re on main (comment out if you don’t want this)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "${CURRENT_BRANCH}" != "${GITBRANCH}" ]]; then
  echo "⚠️  You are on branch: '"${CURRENT_BRANCH}"'...."
  echo "   But releases are usually cut from '${GITBRANCH}'."
  read -rp "Proceed anyway? [Y/N]: " PROCEED_NON_MAIN
  [[ "${PROCEED_NON_MAIN}" =~ ^[Yy]$ ]] || { echo "❎ Aborted."; exit 0; }
fi

# --- Commit/tag messages ----------------------------------------------
DEFAULT_COMMIT_MSG="Release ${VERSION}"
read -rp "Enter commit message [${DEFAULT_COMMIT_MSG}]: " USER_COMMIT_MSG
COMMIT_MSG="${USER_COMMIT_MSG:-${DEFAULT_COMMIT_MSG}}"

DEFAULT_TAG_MSG="${NAME:-AWS Cost Audit} ${VERSION}"
read -rp "Enter tag message [${DEFAULT_TAG_MSG}]: " USER_TAG_MSG
TAG_MSG="New Release - ${USER_TAG_MSG:-${DEFAULT_TAG_MSG}}"

echo
echo "🧾 Version : ${VERSION}"
echo "💬 Commit  : ${COMMIT_MSG}"
echo "🏷️ Tag Msg : ${TAG_MSG}"
read -rp "Proceed with release? [Y/N]: " CONFIRM
[[ "${CONFIRM}" =~ ^[Yy]$ ]] || { echo "❎ Aborted."; exit 0; }

# --- Update CHANGELOG: insert after header section --------------------
DATE_STR=$(date +"%Y-%m-%d")

if [[ -f "${CHANGELOG}" ]]; then
  TMP="$(mktemp)"

  # Find where the first version section starts or where the header ends
  HEADER_END_LINE=$(grep -nE '^---|^## ' "${CHANGELOG}" | head -n1 | cut -d: -f1)

  if [[ -n "${HEADER_END_LINE}" ]]; then
    head -n "${HEADER_END_LINE}" "${CHANGELOG}" > "${TMP}"
    echo "" >> "${TMP}"
    echo "## ${VERSION} — ${DATE_STR}" >> "${TMP}"
    echo "- ${COMMIT_MSG}" >> "${TMP}"
    tail -n +"$((HEADER_END_LINE + 1))" "${CHANGELOG}" >> "${TMP}"
  else
    # fallback if no header marker found
    {
      echo "# Changelog"
      echo ""
      echo "## ${VERSION} — ${DATE_STR}"
      echo "- ${COMMIT_MSG}"
      echo ""
      cat "${CHANGELOG}"
    } > "${TMP}"
  fi

  mv "${TMP}" "${CHANGELOG}"
else
  {
    echo "# Changelog"
    echo ""
    echo "All notable changes to **AWS Cost Audit** will be documented in this file."
    echo "This project follows [Semantic Versioning](https://semver.org/)."
    echo ""
    echo "---"
    echo ""
    echo "## ${VERSION} — ${DATE_STR}"
    echo "- ${COMMIT_MSG}"
    echo ""
  } > "${CHANGELOG}"
fi
#exit 0

# --- Single atomic commit, tag, push ----------------------------------
#git add "${SCRIPT}" "${CHANGELOG}"
git commit -m "${COMMIT_MSG}" . || true
git tag -a "${VERSION}" -m "${TAG_MSG}"
git push origin "${CURRENT_BRANCH}"
git push origin "${VERSION}"

# --- GitHub release (optional) ----------------------------------------
if command -v gh >/dev/null 2>&1; then
  echo "📡 Creating GitHub release from CHANGELOG..."
  gh release create "${VERSION}" "${SCRIPT}" \
    --title "${NAME:-AWS Cost Audit} ${VERSION}" \
    --notes-file "${CHANGELOG}"
  echo "✅ GitHub release published."
else
  echo "⚠️  GitHub CLI (gh) not found — tag created but release skipped."
fi

echo
echo "🎉 Done! Tagged ${VERSION}, updated CHANGELOG, and pushed to origin."
