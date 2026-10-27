# tools/make_submission.R   (Erwyna runs this on submission day)
# ---------------------------------------------------------------------------
# The spec wants ONE .qmd, ONE .html and ONE .pdf inside the document folder.
# While we work, the report is split into section files for teamwork. This script:
#   1. refuses to continue if any TODO marker is left (check_todos.R)
#   2. copies the main .qmd and replaces every {{< include >}} line with the
#      real content of that section, giving one flat .qmd
#   3. builds submission/ErwynaSooW/ with the Rproj, data/, document/
#   4. renders the HTML and the PDF from that clean folder (proves it reproduces)
# Then zip the folder  submission/ErwynaSooW  and upload that zip to Moodle.
# ---------------------------------------------------------------------------
library(tidyverse)
hits <- source("tools/check_todos.R")$value
if (nrow(hits) > 0) stop("Fix the markers above first.", call. = FALSE)

out <- "submission/ErwynaSooW"
unlink("submission", recursive = TRUE)
dir.create(file.path(out, "document"), recursive = TRUE)
dir.create(file.path(out, "data"))

main <- readLines("document/ErwynaSooW.qmd")
flat <- map(main, \(line) {
  m <- str_match(line, "\\{\\{< include \\.\\./sections/(.+\\.qmd) >\\}\\}")
  if (is.na(m[1, 2])) line else c(readLines(file.path("sections", m[1, 2])), "")
}) |> unlist()
# Student IDs are kept out of the public repo. Fill them in from the local, git-ignored csv.
ids <- read_csv("tools/member_ids.csv", show_col_types = FALSE)
flat <- map_chr(flat, \(line) {
  for (i in seq_len(nrow(ids))) {
    if (str_detect(line, fixed(ids$name[i])) && str_detect(line, "withheld \\|\\s*$"))
      line <- str_replace(line, "withheld", as.character(ids$id[i]))
  }
  line
})
if (any(str_detect(flat, "\\| withheld \\|"))) stop("A student ID is still 'withheld'. Check tools/member_ids.csv.", call. = FALSE)
# Drop internal team comments (<!-- ... -->); the marker only needs the report itself
flat <- str_remove_all(paste(flat, collapse = "\n"), regex("<!--.*?-->\\n?", dotall = TRUE)) |>
  str_split_1("\n")
writeLines(flat, file.path(out, "document/ErwynaSooW.qmd"))

file.copy(list.files("data", full.names = TRUE), file.path(out, "data"))
file.copy(c("ErwynaSooW.Rproj"), out)
file.copy("tools/SUBMISSION_README.md", file.path(out, "README.md"))   # how to open and run
file.copy(c("document/style.css", "document/references.bib"), file.path(out, "document"))

# Render from inside the clean folder so any path problem shows up now.
old <- setwd(file.path(out, "document")); on.exit(setwd(old))
# UTF-8 locale so accented letters and symbols render correctly on any machine
system2("quarto", c("render", "ErwynaSooW.qmd"), env = "LANG=en_US.UTF-8")
unlink(file.path(old, out, "document", ".quarto"), recursive = TRUE)  # hidden build cache
# Zip the folder (the zip contains the ErwynaSooW folder itself)
setwd(file.path(old, "submission"))
unlink("ErwynaSooW.zip")
utils::zip("ErwynaSooW.zip", "ErwynaSooW", flags = "-r9Xq")
message("Done. Upload ", file.path(old, "submission", "ErwynaSooW.zip"), " to Moodle.")
