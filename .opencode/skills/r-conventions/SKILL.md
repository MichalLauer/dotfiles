---
name: r-conventions
description: R coding conventions covering safe coding practices, style, naming, functions and formatting. Use for any R code in scripts, Quarto or R Markdown cells, or local projects, and for formatting an R script. Not for R package development.
compatibility: R (>= 4.1)
---
# Long rules

Read these rules when writing or reviewing functions, or when parameter validation matters.

- [functions.md](references/functions.md)

# Code standards

## Naming conventions

- Always write short, descriptive names for variables and functions.
- Use only English, and use snake_case.

```r
# Do
df <- read.csv(...)
model <- lm(...)
# Don't
x <- read.csv(...)
# Exceptions
## Loop variables
for (i in 1:5) {
  # ...
}
## Simulation variables
n <- 100
b <- 5
```

## Code comments

- Write clean, short, and simple code.
- Add comments only where domain knowledge is needed.

```r
# Do
# Because the raw data is broken, we need to identify correct countries and states
df$world <- grepl(df$country, df$state)
# Don't
# Mean of age
mean(df$age)
```

## Scope

- These rules apply everywhere except R package source code: scripts, Quarto/R Markdown cells, and local projects where functions are written without building a package.
- Only for package development, use the `r-package-development` skill instead. Where the two disagree there, that skill wins.

## Code safety

### General R code

- Load all libraries at the top of the script.
- Never use `attach()`.
- Avoid `<<-` and `assign()` to modify variables outside a function's scope.
- Use `vapply()` instead of `sapply()` when the output type matters.
- Set a seed (`set.seed()`) before any code that relies on randomness, so results are reproducible.
- Never call `setwd()`.
- Build paths with `file.path()`.
- Never use `require()`.
- Never use `T` and `F`, always spell out `TRUE` and `FALSE`.
- Instead of `1:length(x)` use `seq_along(x)`.
- Instead of `1:nrow(data)` use `seq_len(nrow(data))`.
- Never call `library()` inside a function.

### Quarto / R Markdown rules

- Use `here::here()` to load files.
- Load all libraries in the very first cell, setting
  - `#| warnings: FALSE` for quarto documents, and
  - `warnings=FALSE` for R Markdown documents.

### Related skills

| Skill | Use for | Source |
|-----------|------------------------------------------------------------|-----------|
| `r-rig` | Running and managing R code, R versions and libraries | Local |
| `r-project` | Project setup, folder layout, `.air.toml`, `AGENTS.md`, git | Local |
| `r-package-development` | R package structure, devtools, `DESCRIPTION` | posit-dev |
| `r-testthat` | Writing and organising tests, snapshots, fixtures | posit-dev |
| `r-cli` | User-facing messages, errors and progress bars | posit-dev |
| `r-tidyverse-style` | Tidyverse idioms (`.by`, `join_by()`, tidy selection). On scripts it never overrides this skill. | posit-dev |
| `quarto-authoring` | Quarto documents, code cells, layouts, tables | posit-dev |

## Piping, chaining

- Use the base pipe `|>` rather than the `{dplyr}`/`{magrittr}` pipe `%>%`.

```r
# Do
df |>
  pull(col1) |>
  mean()
# Don't
df %>%
  pull(col1) %>%
  mean()
```

# Code formatting

## Rules

- Do not read the target R file(s) before formatting.
- Do not read the target R file(s) after formatting, unless the user explicitly asks for a summary of the changes.

## Formatting

- All formatting rules should be defined in `.air.toml` (or `air.toml`) at the project root.
- Inform the user if there is no `.air.toml` (or `air.toml`) in the project root.
- Always write or change R code in the style defined by `air`.
- Whenever you write or change any R code, format the files using the `air` cli tool. Use `--check` only to verify.

```bash
# Check if a single file needs to be formatted
air format --check path_to_file
# Check if any file in the project needs to be formatted
air format --check
# Format a single file
air format path_to_file
# Format all files in the project
air format
```
