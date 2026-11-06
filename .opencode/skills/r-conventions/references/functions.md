# Scope

- These rules apply everywhere except R package source code: scripts, Quarto/R Markdown cells, and local projects where functions are written without building a package.

# Short, one-line, anonymous functions

- Use the anonymous function `\(x) fnc(x)` only as a function argument, for a single short expression.
- Always use `function(x) { ... }` for named functions, even short ones, and for any anonymous function with more than one expression.
- Do not use `~ fnc(.x)` from `{purrr}`.

```r
# Do
vapply(df, FUN = \(x) mean(x), FUN.VALUE = numeric(1))
add_one <- function(x) {
  x + 1
}
# Don't
lapply(df, function(x) mean(x))
lapply(df, ~ mean(.x))
add_one <- \(x) x + 1
```

- When creating named functions, always put parameters on separate lines.

```r
# Do
fun <- function(
  a,
  b = NULL
) {
  # ...
}
# Don't
fun <- function(a, b = NULL) # ...
fun <- function(a, b = NULL) {
  # ...
}
```

# Code safety

- Never call `library()` inside a function.
- Within functions, call external functions with their full name, e.g. `dplyr::bind_rows`, `dplyr::filter`.

# Parameter validation

- Use `{rlang}` to validate arguments and produce clear, informative errors instead of relying on R's default type coercion or cryptic base-R error messages.
- Use `rlang::check_required()` to enforce that a required argument was supplied.
- Use `rlang::arg_match()` to validate that an argument is one of a fixed set of allowed values.
- Use `rlang::abort()` with a descriptive message for other type/shape checks (e.g. length, class, numeric range).

```r
# Do
summarize_col <- function(
  data,
  col,
  stat = c("mean", "median")
) {
  # Parameter validation
  rlang::check_required(data)
  if (!is.data.frame(data)) {
    rlang::abort("`data` must be a data.frame.")
  }
  rlang::check_required(col)
  if (!(col %in% colnames(data))) {
    rlang::abort("`col` must be a column in `data`.")
  }
  stat <- rlang::arg_match(stat)

  # ...
}
# Don't
summarize_col <- function(
  data,
  col,
  stat = c("mean", "median")
) {
  # ...
}
```

# Documentation

- Applies to exported functions of R packages only.
- Document every exported function with roxygen2 comments (`#'`) directly above its definition.
- Always include `@param` for every parameter and a `@return` describing the output.
- Add `@export` only for functions meant to be part of the package's public API.
- Keep the title (first line) to a single short sentence; put longer explanation in the description paragraph below it.

Template structure:

```r
#' <One short title>
#' 
#' <Longer function, possibly split into multiple paragraphs if needed>
#' 
#' @param p1 <short name> (<required: class>)
#'     <Longer description of the parameter>
#' 
#' @param p2 <short name> (<optional: class [default: NULL]>)
#'     <Longer description of the parameter>
#' 
#' @param p3 <short name> (<optional: class [default: 1]>)
#'     <Longer description of the parameter>
#'     <Describe options and their impact.>
#' 
#' @return <What is being returned> [<class>].
#' 
#' @export
function_name <- function(
  p1,
  p2 = NULL,
  p3 = c(1, 2, 3)
) {
  # ...
}
```

Example:

```r
#' Compute variance
#' 
#' Compute variance from a given vector of numerical values.
#' 
#' @param x Input data (required: vector<int>)
#'     Vector of values from which the variance should be computed.
#' 
#' @param population Which version to compute (optional: logical [default: TRUE])
#'     Whether the population variance should be returned or not.
#'     
#'     Options:
#'       FALSE - Return the sample variance.
#'       TRUE - Return the population variance.
#' 
#' @param return_value What value should be returned? (optional: int<1, 2, 3> [default: 1]>)
#'     Which part of the formula should be returned.
#' 
#'     Options:
#'       1 - Return the numerator.
#'       2 - Return the denominator.
#'       3 - Return the computed variance.
#' 
#' @return Computed value, depending on parameter return_value [numeric].
#' 
#' @export
variance <- function(
  x,
  population = FALSE,
  return_value = c(1, 2, 3)
) {
  # ...
}
```