#!/usr/bin/env bash
# Downloads third-party OpenCode skills into the dotfiles repo: .opencode/skills/
# Downloaded skills are git-ignored; this script is the source of truth for them.
# Always overwrites installed skills, always removes its temporary clones.
#
# Works in bash on Linux, macOS (bash 3.2+) and Windows (Git Bash).
# Requires: git, curl (curl only for agent-almanac), internet access.
#
# Usage:  bash scripts/get-skills.sh [options]
#
# Options:
#   --ref=REF    git ref to download (default: main)
#
# Exit codes: 0 done
#             1 error (missing tool, download failed, skill missing in source)

set -u

POSIT_REPO="https://github.com/posit-dev/skills.git"
POSIT_REF="main"
# <skill>:<source folder in the posit-dev repo>
POSIT_SOURCES="
r-cli:r-lib
r-testthat:r-lib
r-package-development:r-lib
r-tidyverse-style:r-lib
quarto-authoring:quarto
shiny-bslib:shiny
shiny-bslib-theming:shiny
shiny-r-optimize:shiny
"

# agent-almanac is a large repo of one-folder-per-skill; files are fetched raw.
ALMANAC_REPO="https://github.com/pjt222/agent-almanac"
ALMANAC_REF="main"
ALMANAC_PATH="skills"
ALMANAC_SKILLS="
build-shiny-module
write-roxygen-docs
"

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$DOTFILES/.opencode/skills"
REF=""
for arg in "$@"; do
  case "$arg" in
    --ref=*)  REF="${arg#*=}" ;;
    -h|--help) sed -n '2,16p' "${BASH_SOURCE[0]}"; exit 0 ;;
    *) echo "Unknown option: $arg"; exit 1 ;;
  esac
done
POSIT_REF="${REF:-$POSIT_REF}"
ALMANAC_REF="${REF:-$ALMANAC_REF}"

if ! command -v git >/dev/null 2>&1; then
  echo "git is not installed: https://git-scm.com/downloads"; exit 1
fi

tmp="$(mktemp -d 2>/dev/null || mktemp -d -t skills)" || {
  echo "Could not create a temporary directory"; exit 1
}
trap 'rm -rf "$tmp"' EXIT

# ---------------------------------------------------------------- posit-dev
echo "Downloading $POSIT_REPO ($POSIT_REF)"
if ! git clone --quiet --depth 1 --branch "$POSIT_REF" --filter=blob:none --sparse \
    "$POSIT_REPO" "$tmp/posit"; then
  echo "Failed to clone $POSIT_REPO"; exit 1
fi

# Sparse checkout needs the full paths, one per skill.
paths=""
for entry in $POSIT_SOURCES; do
  paths="$paths ${entry#*:}/${entry%%:*}"
done
if ! (cd "$tmp/posit" && git sparse-checkout set $paths >/dev/null); then
  echo "Failed to check out the skill folders"; exit 1
fi

failed=0
for entry in $POSIT_SOURCES; do
  if [ ! -f "$tmp/posit/${entry#*:}/${entry%%:*}/SKILL.md" ]; then
    echo "Not found in source: ${entry#*:}/${entry%%:*}"
    failed=1
  fi
done
[ "$failed" -eq 1 ] && { echo "Nothing was installed."; exit 1; }

# ------------------------------------------------------------ agent-almanac
echo "Downloading $ALMANAC_REPO ($ALMANAC_REF)"
if ! command -v curl >/dev/null 2>&1; then
  echo "curl is not installed (needed for $ALMANAC_REPO)"; exit 1
fi

mkdir -p "$tmp/almanac"
for skill in $ALMANAC_SKILLS; do
  mkdir -p "$tmp/almanac/$skill"
  if ! curl -fsSL \
      "$ALMANAC_REPO/raw/$ALMANAC_REF/$ALMANAC_PATH/$skill/SKILL.md" \
      -o "$tmp/almanac/$skill/SKILL.md"; then
    echo "Not found in source: $ALMANAC_PATH/$skill"
    failed=1
  fi
done
[ "$failed" -eq 1 ] && { echo "Nothing was installed."; exit 1; }

# ---------------------------------------------------------------- install
mkdir -p "$DEST" || { echo "Cannot create $DEST"; exit 1; }

install_skill() {
  src="$1"
  skill="$(basename "$src")"
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
}

for entry in $POSIT_SOURCES; do
  install_skill "$tmp/posit/${entry#*:}/${entry%%:*}"
done
for skill in $ALMANAC_SKILLS; do
  install_skill "$tmp/almanac/$skill"
done

# ---------------------------------------------------------------- local patches
# Only mechanical renames, so a fresh download already follows this repo's
# naming. Behaviour changes (module naming convention, opt-in @examples) live in
# the local shiny-app skill, not here, because local skills survive updates.
patch() {
  file="$1"; from="$2"; to="$3"
  [ -f "$file" ] || return 0
  if grep -qF "$from" "$file"; then
    sed -i.bak "s|$from|$to|g" "$file" && rm -f "$file.bak"
  fi
}

# Snake_case module functions instead of dataFilterUI/dataFilterServer.
for f in "$DEST/build-shiny-module/SKILL.md"; do
  patch "$f" "dataFilterUI" "data_filter_ui"
  patch "$f" "dataFilterServer" "data_filter_server"
  patch "$f" "analysisUI" "analysis_ui"
  patch "$f" "analysisServer" "analysis_server"
  patch "$f" "summaryServer" "summary_server"
done

[ "$failed" -eq 1 ] && exit 1
exit 0
