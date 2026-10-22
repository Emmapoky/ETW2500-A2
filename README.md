# ETW2500 Assignment 3: team guide (read this first)

Repository: https://github.com/Emmapoky/ETW2500-A2 (public, so **never put anything private in it**: no passwords, no
student ID numbers, no personal files). Project name inside RStudio: `ErwynaSooW`.
Rules for working in the repo are in [CONTRIBUTING.md](CONTRIBUTING.md); the Git steps are in [GIT_GUIDE.md](GIT_GUIDE.md).

Due **Monday 2 November 2026, 11:55 PM**. Group leader: Erwyna Soo Wen Xin. Internal target: submitted by noon.

## How this project is organised

The final report must be ONE Quarto file, but we cannot all edit one file at once. So the report is split into
**section files**, one per person, inside `sections/`. `document/ErwynaSooW.qmd` just stitches them together in order.
On submission day Erwyna runs `tools/make_submission.R`, which glues the sections into the single file the spec asks for.

**Rule 1: edit only your own section file.** Never edit someone else's, and never write analysis in the main qmd.

| File in `sections/` | Owner | What it is |
|---|---|---|
| `01_introduction.qmd` | Erwyna | Business problem, objectives, executive summary |
| `02_how_to_reproduce.qmd` | Riely | Numbered steps to reproduce the report |
| `03_setup_and_data.qmd` | Erwyna | Packages, seed, theme, data loading. Done |
| `04_q1a_distances.qmd` | Taabish | Question 1 Part A, items 1 to 3 |
| `05_q1b_maxbrshare.qmd` | Riely | Question 1 Part B, items 4 to 7 |
| `06_q2a_variables.qmd` | Taabish | Question 2(a), choose exactly six variables |
| `07_q2b_data_prep.qmd` | Erwyna | Question 2(b), missing values, skew, standardise. Done |
| `08_q2cd_clustering.qmd` | Shrrii | Question 2(c) and (d), clustering and describing groups |
| `09_q2e_profiling.qmd` | Nandhini | Question 2(e), profile groups with three demographics |
| `10_q3_pca.qmd` | Nandhini | Question 3, PCA |
| `11_conclusion.qmd` | Erwyna | Findings, recommendations, limitations |
| `12_appendix.qmd` | Riely | Package versions, sessionInfo, references |

Open your file. At the top is a grey comment block called **INSTRUCTIONS FOR YOUR NAME**: it says exactly what the
spec asks, what I already did for you, the hints, and the extras for an HD. Every unfinished job is tagged `TODO(YourName)`.

## First time setup (everyone, 10 minutes)

1. Install R, RStudio and Quarto (versions used: see the appendix once written).
2. Get the project folder: clone the repository (see GIT_GUIDE.md).
3. **Double click `ErwynaSooW.Rproj`.** Always start from this file. It sets the working folder, and every path
   in the report depends on it.
4. In the RStudio console run `source("tools/load_upstream.R")`.
5. Load everything that comes before your section, for example Shrrii runs
   `load_upstream("08_q2cd_clustering")`. Now the objects you need (`soap`, `cluster_vars`, `soap_prep` ...) exist in your console
   and you can run your own chunks one by one.
6. When you want to see the whole report, open `document/ErwynaSooW.qmd` and press **Render**. The first render installs
   missing packages and needs internet.

## The shared objects (do not rename them, other people's code uses them)

| Object | Made in | Meaning |
|---|---|---|
| `soap_raw` | 03 | The data exactly as read |
| `soap` | 05 | Raw data plus `MaxBrShare` |
| `cluster_vars` | 06 | The six chosen variable names |
| `soap_clean` | 07 | All 600 households, demographics with NA for "not specified" |
| `soap_prep` | 07 | MemberID plus the six variables, skew corrected and standardised. Cluster this, run PCA on this |
| `soap_clusters` | 08 | MemberID and `cluster` (a factor). Shrrii hands this over |

## Style rules for the report

- Use the packages already loaded in section 03 (tidyverse, tidymodels, factoextra, cluster, dendextend, gt). Prefer
  functions from the lectures and tutorials: the marker can ask what any function in our code does.
- Comment every non trivial line of code in plain English so you can explain it out loud with no notes.
- Under every table or plot write what it means. The interpretation is worth 30 of the 100 marks.
- Never type a number from an output by hand. Use inline R, for example `` `r nrow(soap)` ``, so text and output cannot disagree.
- No en dashes or em dashes in the text. Use commas, full stops or colons.
- Do not set a seed in your section unless you run something random. The seed (55789) is set once in section 03.

## Before you hand your section over

1. Delete your INSTRUCTIONS comment block and every `TODO(YourName)` line.
2. Change `eval: false` to `eval: true` on your chunks.
3. Run `source("tools/check_todos.R")`: it must not list any line from your file.
4. Render the whole report once. If it fails in your section, fix it before telling anyone.

## Deadlines

See the team plan Google Doc. Short version: first drafts Sat 24 Oct noon (Taabish, Riely, Erwyna) and Wed 28 Oct noon
(Shrrii, Nandhini). All final Fri 30 Oct. Meetings: Wed 21 Oct, Sun 25 Oct, Wed 28 Oct, Sat 31 Oct, Sun 1 Nov.
