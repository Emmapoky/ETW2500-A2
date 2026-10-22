# tools/check_todos.R
# Run before every merge and before submitting:  source("tools/check_todos.R")
# It lists every unfinished instruction. The report is only ready when this prints
# "Clean". Every instruction in the sections is tagged TODO(Name) so it is findable.
files <- list.files("sections", pattern = "\\.qmd$", full.names = TRUE)
hits <- purrr::map_dfr(files, \(f) {
  lines <- readLines(f, warn = FALSE)
  idx <- grep("TODO\\(|PROVISIONAL|STARTER|INSTRUCTIONS FOR", lines)
  tibble::tibble(file = basename(f), line = idx, text = trimws(substr(lines[idx], 1, 90)))
})
if (nrow(hits) == 0) {
  message("Clean: no TODO, PROVISIONAL, STARTER or INSTRUCTIONS markers left.")
} else {
  print(hits, n = Inf)
  message(nrow(hits), " marker(s) left. Remove each one only when its job is done.")
}
invisible(hits)
