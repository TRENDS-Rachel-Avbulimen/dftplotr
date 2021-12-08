# Evaluates all arguments (see #81)
force_all <- function(...) list(...)

range_finite <- function(x) {
  suppressWarnings(range(x, na.rm = TRUE, finite = TRUE))
}

seq2 <- function(from, to) {
  if (from > to) {
    numeric()
  } else {
    from:to
  }
}

#' Label numbers in decimal format (e.g. 0.12, 1,234)
#'
#' Use `label_number()` force decimal display of numbers (i.e. don't use
#' [scientific][label_scientific] notation). `label_comma()` is a special case
#' that inserts a comma every three digits.
#'
#' @return
#' All `label_()` functions return a "labelling" function, i.e. a function that
#' takes a vector `x` and returns a character vector of `length(x)` giving a
#' label for each input value.
#'
#' Labelling functions are designed to be used with the `labels` argument of
#' ggplot2 scales. The examples demonstrate their use with x scales, but
#' they work similarly for all scales, including those that generate legends
#' rather than axes.
#' @section Old interface:
#' `number_format()`, `comma_format()`, and `comma()` are retired; please use
#' `label_number()` and `label_comma()` instead.
#' @param x A numeric vector to format.
#' @param accuracy A number to round to. Use (e.g.) `0.01` to show 2 decimal
#'   places of precision. If `NULL`, the default, uses a heuristic that should
#'   ensure breaks have the minimum number of digits needed to show the
#'   difference between adjacent values.
#'
#'   Applied to rescaled data.
#' @param scale A scaling factor: `x` will be multiplied by `scale` before
#'   formatting. This is useful if the underlying data is very small or very
#'   large.
#' @param prefix,suffix Symbols to display before and after value.
#' @param big.mark Character used between every 3 digits to separate thousands.
#' @param decimal.mark The character to be used to indicate the numeric
#'   decimal point.
#' @param trim Logical, if `FALSE`, values are right-justified to a common
#'   width (see [base::format()]).
#' @param ... Other arguments passed on to [base::format()].
#' @examples
#' demo_continuous(c(-1e6, 1e6))
#' demo_continuous(c(-1e6, 1e6), labels = label_number())
#' demo_continuous(c(-1e6, 1e6), labels = label_comma())
#'
#' # Use scale to rescale very small or large numbers to generate
#' # more readable labels
#' demo_continuous(c(0, 1e6), labels = label_number())
#' demo_continuous(c(0, 1e6), labels = label_number(scale = 1 / 1e3))
#' demo_continuous(c(0, 1e-6), labels = label_number())
#' demo_continuous(c(0, 1e-6), labels = label_number(scale = 1e6))
#'
#' # You can use prefix and suffix for other types of display
#' demo_continuous(c(32, 212), label = label_number(suffix = "\u00b0F"))
#' demo_continuous(c(0, 100), label = label_number(suffix = "\u00b0C"))

label_number <- function(accuracy = NULL, scale = 1, prefix = "",
                         suffix = "", big.mark = " ", decimal.mark = ".",
                         trim = TRUE, ...) {
  force_all(
    accuracy,
    scale,
    prefix,
    suffix,
    big.mark,
    decimal.mark,
    trim,
    ...
  )
  function(x) scales::number(
    x,
    accuracy = accuracy,
    scale = scale,
    prefix = prefix,
    suffix = suffix,
    big.mark = big.mark,
    decimal.mark = decimal.mark,
    trim = trim,
    ...
  )
}