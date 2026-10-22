# tools/load_upstream.R
# ---------------------------------------------------------------------------
# WHY THIS EXISTS
# The report is one Quarto document built from many section files. Your section
# needs the objects the earlier sections create (for example `soap`, `cluster_vars`,
# `soap_prep`). This function runs the code of every section that comes BEFORE
# yours, silently, in your R console, so you can work on your own section file
# chunk by chunk without rendering the whole report each time.
#
# HOW TO USE (from the project root, i.e. with ErwynaSooW.Rproj open):
#   source("tools/load_upstream.R")
#   load_upstream("08_q2cd_clustering")          # Shrrii
#   load_upstream("09_q2e_profiling", dummy_clusters = TRUE)   # Nandhini, see below
#   load_upstream("10_q3_pca")                   # Nandhini
#
# `dummy_clusters = TRUE` creates a THROWAWAY random `soap_clusters` in your console
# only (it never goes into any file) so Nandhini can build the profiling code
# before Shrrii has finished. Real clusters replace it automatically once the
# clustering section is merged, because upstream code runs first.
# ---------------------------------------------------------------------------

section_order <- c(
  "03_setup_and_data", "04_q1a_distances", "05_q1b_maxbrshare",
  "06_q2a_variables", "07_q2b_data_prep", "08_q2cd_clustering",
  "09_q2e_profiling", "10_q3_pca"
)

load_upstream <- function(my_section, dummy_clusters = FALSE) {
  stopifnot(requireNamespace("knitr", quietly = TRUE), file.exists("sections"))
  stopifnot(my_section %in% section_order)
  before <- section_order[seq_len(match(my_section, section_order) - 1)]
  for (s in before) {
    tmp <- tempfile(fileext = ".R")
    # purl() pulls the R chunks out of a qmd; chunks marked eval: false stay out.
    knitr::purl(file.path("sections", paste0(s, ".qmd")), output = tmp,
                documentation = 0, quiet = TRUE)
    message("running upstream section: ", s)
    source(tmp, local = globalenv(), echo = FALSE)
  }
  if (dummy_clusters && !exists("soap_clusters", envir = globalenv())) {
    set.seed(1)
    assign("soap_clusters",
           dplyr::tibble(MemberID = soap$MemberID,
                         cluster = factor(sample(1:3, nrow(soap), TRUE))),
           envir = globalenv())
    message("DUMMY random clusters created in your console only. Not real results.")
  }
  invisible(before)
}
