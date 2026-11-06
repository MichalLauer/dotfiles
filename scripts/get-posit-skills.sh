#!/usr/bin/env bash
# Downloads the latest posit-dev R skills into the dotfiles repo: .opencode/skills/
# Downloaded skills are git-ignored; this script is the source of truth for them.
# Always overwrites installed skills, always removes its temporary clone.
#
# Works in bash on Linux, macOS (bash 3.2+) and Windows (Git Bash).
# Requires: git, internet access.
#
# Usage:  bash scripts/get-posit-skills.sh [options]
#
# Options:
#   --ref=REF    git ref to download (default: main)
#
# Exit codes: 0 done
#             1 error (missing tool, download failed, skill missing in source)

set -u

POSIT_REPO="https://github.com/posit-dev/skills.git"
# <skill>:<source folder in the posit-dev repo>
SOURCES="
r-cli:r-lib
r-testthat:r-lib
r-package-development:r-lib
r-tidyverse-style:r-lib
quarto-authoring:quarto
"

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$DOTFILES/.opencode/skills"
REF="main"

for arg in "$@"; do
  case "$arg" in
    --ref=*)  REF="${arg#*=}" ;;
    -h|--help) sed -n '2,15p' "${BASH_SOURCE[0]}"; exit 0 ;;
    *) echo "Unknown option: $arg"; exit 1 ;;
  esac
done

if ! command -v git >/dev/null 2>&1; then
  echo "git is not installed: https://git-scm.com/downloads"; exit 1
fi

tmp="$(mktemp -d 2>/dev/null || mktemp -d -t posit-skills)" || {
  echo "Could not create a temporary directory"; exit 1
}
trap 'rm -rf "$tmp"' EXIT

echo "Downloading $POSIT_REPO ($REF)"
if ! git clone --quiet --depth 1 --branch "$REF" --filter=blob:none --sparse \
    "$POSIT_REPO" "$tmp/skills"; then
  echo "Failed to clone $POSIT_REPO"; exit 1
fi

# Sparse checkout needs the full paths, one per skill.
paths=""
for entry in $SOURCES; do
  paths="$paths ${entry#*:}/${entry%%:*}"
done
if ! (cd "$tmp/skills" && git sparse-checkout set $paths >/dev/null); then
  echo "Failed to check out the skill folders"; exit 1
fi

failed=0
for entry in $SOURCES; do
  skill="${entry%%:*}"
  src="$tmp/skills/${entry#*:}/$skill"
  if [ ! -f "$src/SKILL.md" ]; then
    echo "Not found in source: ${entry#*:}/$skill"; failed=1
  fi
done
if [ "$failed" -eq 1 ]; then
  echo "Nothing was installed."; exit 1
fi

mkdir -p "$DEST" || { echo "Cannot create $DEST"; exit 1; }
for entry in $SOURCES; do
  skill="${entry%%:*}"
  src="$tmp/skills/${entry#*:}/$skill"
  new="$DEST/.$skill.tmp.$$"
  rm -rf "$new"
  if cp -R "$src" "$new" &&
      rm -rf "$DEST/$skill" &&
      mv "$new" "$DEST/$skill"; then
    echo "Installed $skill -> $DEST/$skill"
  else
    rm -rf "$new"
    echo "Failed to install $skill"; failed=1
  fi
done

[ "$failed" -eq 1 ] && exit 1
exit 0
