# Sharing the project: GitHub, step by step

The repository already exists: **https://github.com/Emmapoky/ETW2500-A2** (owner: Erwyna, public).
Use **GitHub Desktop** (a point and click app, https://desktop.github.com) so nobody needs the command line.
The project is split into one file per person, so two people almost never edit the same file, which means almost no conflicts.

## Erwyna: one time

1. On github.com open the repository > Settings > Collaborators > Add people. Add Taabish, Nandhini, Riely and Shrrii by GitHub
   username or email. (On a public repository anyone can READ it, but only collaborators can PUSH.)
2. Optional but recommended: Settings > Branches > leave `main` unprotected so everyone can push their own section.

## Everyone else: one time

1. Make a free GitHub account, send Erwyna your username, and accept the invitation email.
2. In GitHub Desktop: File > Clone repository > pick `Emmapoky/ETW2500-A2` > choose a folder > Clone.
3. Double click `ErwynaSooW.Rproj` inside the cloned folder and follow README.md.

## Every working session (the whole routine)

1. Open GitHub Desktop and press **Fetch origin**, then **Pull origin**. Always pull BEFORE you start, so you have everyone's latest work.
2. Edit only your own section file in RStudio. Run it, check it works.
3. In GitHub Desktop you will see your changed file. Write a short message saying what you did
   (for example "Q3: scree plot and variance table"), press **Commit to main**, then **Push origin**.
4. Commit small and often, at least at the end of every session. A commit is a saved checkpoint you can go back to.

## If you ever see a conflict

It only happens if two people edited the same lines. Do not choose at random. Message the group, say which file, and let the owner
of that file decide. Erwyna resolves it on a call.

## From a terminal instead (optional)

```bash
git clone https://github.com/Emmapoky/ETW2500-A2.git
cd ETW2500-A2
git pull            # every session, before you start
git add sections/YOUR_FILE.qmd
git commit -m "what you did"
git push
```

## Rules

- One person per file. If you must change someone else's section, ask them first.
- Never commit rendered files (.html, .pdf): they are blocked by `.gitignore` on purpose.
- Never commit student ID numbers, passwords or personal files. The repository is public.
- Delete nothing that you did not create.
