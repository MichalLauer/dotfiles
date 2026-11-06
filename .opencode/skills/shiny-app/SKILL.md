---
name: shiny-app
description: Package a Shiny app as a plain R package without golem or rhino. Use when starting a Shiny app, structuring app files in an R package, exporting app_ui/app_server, writing run_app(), adding modules, or deciding how a Shiny app is launched, tested and shared. Pairs with r-package-development.
compatibility: R (>= 4.1), shiny, bslib
---
# Shiny app as a plain R package

A Shiny app is developed as a normal R package: `DESCRIPTION`, `NAMESPACE`, `R/`, `tests/testthat/`, roxygen2. No `golem`, no `rhino`, no `{box}`, no `app.R` at the project root.

## Package layout

| Path | Holds |
| --- | --- |
| `R/app_ui.R` | `app_ui()`: page layout, theme, top-level inputs |
| `R/app_server.R` | `app_server()`: reactives and outputs |
| `R/run_app.R` | `run_app()`: the single exported entry point |
| `R/mod_<name>.R` | one module per file: `<name>_ui()`, `<name>_server()` |
| `R/<name>.R` | other functions, one concern per file |
| `inst/app/www/` | static assets (CSS, JS, images), read with `system.file()` |
| `tests/testthat/` | `testServer()` unit tests, `test-<name>.R` per file |

## Rules

These override the downloaded Shiny and documentation skills where they disagree:

- Module files and functions: `mod_<name>.R`, `<name>_ui()`, `<name>_server()`, all snake_case. Never `<name>UI`/`<name>Server`.
- `@examples` only when the user asks for one, even though `write-roxygen-docs` recommends them.
- No `golem`, `rhino`, renv, CRAN submission or CI scaffolding from other skills.
- No `library()` in package code; the examples here use `shiny::` and `bslib::` for that reason. For a quick throwaway script outside a package, `r-conventions` applies instead.
- Export `run_app()` and `app_ui()`. Leave `app_server` unexported unless a test or another package calls it directly.
- Call other packages' functions with `::` (`shiny::reactive()`, `bslib::card()`). Add them to `Imports` in `DESCRIPTION`, never `library()` in package code.
- Load data once at package scope or in a `reactive()`, never inside a render function.
- Put static files in `inst/app/www/` and reference them with `system.file("app/www", ..., package = "<pkg>")` or `addResourcePath()`. Never use `setwd()`.
- Follow `r-package-development` for roxygen2, tests, `NEWS.md` and `devtools::check()`.

## `app_ui()` and `app_server()`

```r
#' App UI
#'
#' @return A bslib page.
#' @export
app_ui <- function() {
  bslib::page_sidebar(
    title = "App",
    sidebar = bslib::sidebar(
      mod_filter_ui("filter")
    ),
    bslib::card(
      shiny::plotOutput("plot")
    )
  )
}

app_server <- function(
  input,
  output,
  session
) {
  filtered <- mod_filter_server("filter", data = shiny::reactive(mtcars))

  output$plot <- shiny::renderPlot({
    shiny::req(filtered())
    graphics::hist(filtered()$mpg)
  })
}
```

## `run_app()`

Always provide it, even when `runApp()` on the package directory would work. It gives the user one entry point and lets `DESCRIPTION` stay free of `shiny` in `Depends`.

```r
#' Run the app
#'
#' @param port Port to listen on.
#' @param launch.browser Open the app in a browser.
#' @return Called for its side effect; returns invisibly.
#' @export
run_app <- function(
  port = NULL,
  launch.browser = TRUE
) {
  shiny::runApp(
    shiny::shinyApp(ui = app_ui, server = app_server),
    port = port,
    launch.browser = launch.browser
  )
}
```

## Running during development

- Run the app with `Rscript -e "devtools::load_all(); run_app()"`.
- Never `devtools::install()` on every change; `load_all()` is enough.
- Run tests with `Rscript -e "devtools::test()"`.

## Testing

- Test module server logic with `testServer()` in `tests/testthat/test-mod_<name>.R`. Add `shinytest2` to `Suggests` only when end-to-end tests are wanted.
- Set inputs with `session$setInputs()`, then assert on the module's returned reactive.

```r
test_that("filter module keeps only the chosen species", {
  testServer(
    mod_filter_server,
    args = list(data = shiny::reactive(iris)),
    {
      session$setInputs(column = "Species", value_select = "setosa", apply = 1)
      expect_equal(nrow(filtered()), 50)
    }
  )
})
```

- Run with `Rscript -e "devtools::test()"`. Do not add CI configuration.

## Related skills

| Skill | Use for | Source |
| --- | --- | --- |
| `r-package-development` | `DESCRIPTION`, roxygen2, tests, `NEWS.md`, `check()` | posit-dev |
| `build-shiny-module` | module pairs, `NS()`, reactive return values | agent-almanac |
| `shiny-bslib` | page layouts, cards, value boxes, inputs | posit-dev |
| `shiny-bslib-theming` | `bs_theme()`, dark mode, brand.yml | posit-dev |
| `shiny-r-optimize` | slow app, caching, async | posit-dev |
| `write-roxygen-docs` | roxygen2 tags for exported functions | agent-almanac |
| `r-rig` | running R code and the project library | Local |
