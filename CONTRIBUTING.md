# Contributing rules (ETW2500 Assignment 3 group)

1. **Edit only your own section file** in `sections/`. The owner table is in README.md. Ask the owner before touching anyone else's file.
2. **Pull before you start, push before you stop.** Commit small and often, with a message that says what changed.
3. **Never commit rendered output** (.html, .pdf), student IDs, passwords or personal files. This repository is public.
4. **Do not rename the shared objects** (`soap`, `cluster_vars`, `soap_clean`, `soap_prep`, `soap_clusters`). Other sections use them.
5. **Before handing a section over:** delete your INSTRUCTIONS comment block and every `TODO(YourName)`, set `eval: true` on your
   chunks, run `source("tools/check_todos.R")`, then render the whole report once. Fix any error before telling the group.
6. **Interpretation under every output**, and inline R (never hand typed numbers) in the text.
7. **No en dashes or em dashes** in text. Use commas, full stops or colons.
8. **Only Erwyna** runs `tools/make_submission.R`, edits `document/ErwynaSooW.qmd` and submits on Moodle.
9. Stuck for more than 30 minutes? Post in the group chat. Silence is the one thing that hurts the group.
