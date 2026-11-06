---
name: r-project
description: Set up an R project with git, the standard folder layout, AGENTS.md, a <folder>.code-workspace for VS Code, .air.toml, air and a rig project. Use when starting or standardising an R project.
compatibility: "R (>= 4.1), rig (>= 0.11.0), uv, air-formatter, git"
---
# R project setup

1. From the project root (do not cd elsewhere), run: `bash <skill-dir>/scripts/setup-project.sh --no-prompt`
   - It configures git and rig, creates the folder layout, and adds `AGENTS.md`, `<folder>.code-workspace` and `.air.toml`.
   - The project root is where `git init`, the `.air.toml` and the folders belong; do not create a nested subfolder for it.
2. Exit code 10: nothing was changed. The script lists questions. Ask the user each one, then re-run with `--no-prompt` plus the flags it names.
3. Exit codes 0, 20, 30, 1: the steps are independent and all ran as far as they could. Report the SUMMARY block to the user.
4. Exit code 30: a tool is missing. Tell the user which one and give the link from the output.
5. Exit code 20: the user declined installing air, so air and .air.toml were skipped.
6. Exit code 1: a step failed. Report the error. Do not retry with other commands.
7. If the output contains "ACTION REQUIRED ... merge AGENTS.md", read both files and merge them as described.

# Folder layout

The standard layout, created by the folder step of `setup-project.sh`. Only missing folders are created; existing files are never touched.

| Folder | Holds |
| --- | --- |
| `data/bronze/` | Raw data as received. Never edited by hand after it lands here. |
| `data/silver/` | Cleaned data, one table per source or concept. |
| `data/gold/` | Analysis-ready data used for reporting. |
| `R/` | R source files: functions and scripts. |
| `output/` | Generated tables, figures and artefacts. |
| `docs/` | Documentation and reports. |

# Rules

- Never answer for the user.
- Never install anything on your own, including uv, rig, git and R.