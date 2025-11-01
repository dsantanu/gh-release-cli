#!/usr/bin/env bash
# =====================================================================
#  release.sh — Automated GitHub release helper for AWS Cost Audit
#  Author : Santanu Das (@dsantanu)
#  License: MIT
#  Desc   : Automatically extract metadata, tag the release, and
#           publish to GitHub using the GitHub CLI (gh).
# =====================================================================

set -euo pipefail

# --- Extract metadata from aws-cost-audit script ----------------------
SCRIPT="aws-cost-audit.sh"

NAME=$(awk -F':' '/^# Name/ {print $2}' "${SCRIPT}" | xargs)
VERSION=$(awk -F':' '/^# Version/ {print $2}' "${SCRIPT}" | xargs)
AUTHOR=$(awk -F':' '/^# Author/ {print $2}' "${SCRIPT}" | xargs)
DESC=$(awk -F':' '/^# Desc/ {print $2}' "${SCRIPT}" | xargs)

# --- Sanity checks ----------------------------------------------------
if [[ -z "${VERSION}" ]]; then
  echo "❌ Could not determine version from ${SCRIPT}"
  exit 1
fi

# --- Prepare changelog and release commit -----------------------------
DEFAULT_COMMIT_MSG="Release ${VERSION}"
read -rp "Enter commit message [${DEFAULT_COMMIT_MSG}]: " USER_COMMIT_MSG
COMMIT_MSG="${USER_COMMIT_MSG:-$DEFAULT_COMMIT_MSG}"

DEFAULT_TAG_MSG="${NAME} ${VERSION}"
read -rp "Enter tag message [${DEFAULT_TAG_MSG}]: " USER_TAG_MSG
TAG_MSG="${USER_TAG_MSG:-$DEFAULT_TAG_MSG}"

# --- Confirm before proceeding ----------------------------------------
echo
echo "🧾 Version : ${VERSION}"
echo "💬 Commit  : ${COMMIT_MSG}"
echo "🏷️ Tag Msg : ${TAG_MSG}"
echo ""
read -rp "Proceed with release? [Y/N]: " CONFIRM
[[ "${CONFIRM}" =~ ^[Yy]$ ]] || { echo "❎ Aborted."; exit 0; }

# --- Update CHANGELOG before commit ----------------------------------
CHANGELOG="CHANGELOG.md"
DATE_STR=$(date +"%Y-%m-%d")

# Create or prepend changelog entry
if [[ -f "${CHANGELOG}" ]]; then
  TEMP_FILE=$(mktemp)
  {
    echo "## ${VERSION} — ${DATE_STR}"
    echo ""
    echo "- ${COMMIT_MSG}"
    echo ""
    cat "${CHANGELOG}"
  } > "${TEMP_FILE}"
  mv "${TEMP_FILE}" "${CHANGELOG}"
else
  {
    echo "# Changelog"
    echo ""
    echo "All notable changes to this project will be documented in this file."
    echo ""
    echo "## ${VERSION} — ${DATE_STR}"
    echo ""
    echo "- ${COMMIT_MSG}"
    echo ""
  } > "${CHANGELOG}"
fi

# --- Commit, tag, and push in one flow -------------------------------
git add "$SCRIPT" "${CHANGELOG}"
git commit -m "${COMMIT_MSG}" || true
git tag -a "${VERSION}" -m "${TAG_MSG}"
git push origin main
git push origin "${VERSION}"

# --- Optional: Create GitHub release ---------------------------------
if command -v gh >/dev/null 2>&1; then
  echo "📡 Creating GitHub release from updated CHANGELOG..."
  gh release create "${VERSION}" "$SCRIPT" \
    --title "${NAME} ${VERSION}" \
    --notes-file "${CHANGELOG}"
  echo "✅ GitHub release published."
else
  echo "⚠️  GitHub CLI (gh) not found — tag created but release skipped."
  echo "   Run manually later: gh release create ${VERSION} --title ..."
fi

echo
echo "🎉 Done! Tagged ${VERSION} and pushed to origin."
