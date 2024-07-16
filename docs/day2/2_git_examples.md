---
title: 2. Git Workflow Basics
layout: page
nav_order: 2
parent: Day 2
updateDate: 2024-07-10
---

# {{ page.title }}
---

Having described Git's model for tracking changes, we can now describe the basic commands that operationalize it. To get started, `ssh` into one of the Yen servers (if you need a refresher, [this page](/rf_bootcamp_2024/day1/4_the_yens) from Day 1 has instructions).

## Setting up a Git repository

### Creating a Git repository from scratch

Once you're logged in to a Yen, either [change your working directory](/rf_bootcamp_2024/day1/2_directories_and_paths) to the `~/test_project` folder you created on Day 1 or [create a new directory](/rf_bootcamp_2024/day1/2_directories_and_paths) `~/test_project` and then change your working directory to it.

A Git repository is simply a folder with some additional metadata stored inside. To initialize a Git repository in a given directory (e.g. `~/test_project`), use the `init` subcommand of the `git` program from within the directory you want to turn into a Git repository:
```bash
SUNetID@yen4:~/test_project$ git init
```

Doing so creates a folder called `.git` inside the target directory that Git uses to store data for tracking changes. All files and folders whose names start with `.` are hidden by “ls” by default; use the “-a” flag to see them:
```bash
SUNetID@yen4:~/test_project$ ls -a
```
If you delete the `.git` directory inside the folder corresponding a Git repository, you'll delete all of the change history for the repository and revert the repository back to a regular old file system directory. Be careful; whatever state your repository is in when you delete the `.git` folder will be the state it's left in, so any history on branches other than the current branch will be permanently deleted.

We won't be using this repository for the remainder of today, so feel free to delete the `~/test_project` folder using the `rm` command (don't forget the `-r` flag).

### Cloning a remote Git repository

Often, you'll want to download an existing Git repository to a machine you have access to so you can run and/or modify the code in it yourself; doing so is quite common when collaborating with others or working with open-source software. The Git vocabulary term for doing so is **cloning** a repository.

Today, we'll be working with a version of the basic project directory we created yesterday; we've uploaded it to a remote Git repository hosted by Github that also contains the source code for this website. To clone the repository to your ZFS home directory on the Yens, run the following command:
```bash
SUNetID@yen4:~$ git clone https://github.com/gsbdarc/rf_bootcamp_2024.git
```

Once you've run that command, change your working directory to the `~/rf_bootcamp_2024/examples/day2/test_project` folder, and, just like yesterday, create a file in the `./data` folder called `input.txt` that contains the text `Hello, World!` using Vim (see [these](/rf_bootcamp_2024/day1/5_editing_files) [pages](/rf_bootcamp_2024/day1/6_running_code) from Day 1 if you want a refresher).

## Commits

Recall that a Git commit is a snapshot of a set of changes to some subset of the files and folders in a repository. To demonstrate how to make a commit, we'll first make a change to one of the files the just-cloned repository: change the `toupper` function call to `tolower` in the `~/rf_bootcamp_2024/examples/day2/test_project/src/test_script.R` file using Vim.

### Staging files

To create a Git commit, we have to specify which files' changes we want to include in that commit. To do so, we use the `add` subcommand to **stage** changes. In particular, to stage the change we just made to the `test_script.R` file for inclusion in the next commit we'll soon make, we run the following command:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git add src/test_script.R
```

To undo the staging of a change to some file for a commit, use the `reset` command:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git reset -- src/test_script.R
```

Less tediously, you can stage entire directories by running `git add <DIRECTORY_PATH>`, but it's usually good to not stage all of your changes at once (e.g. you can save changes to some files for later commits):
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git add src
```

To see what changes have been staged for the next commit, use the `status` subcommand:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   examples/day2/test_project/src/test_script.R

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        examples/day2/test_project/data/input.txt
```
Notice that the status command lists both the files/folders with changes that are staged for the next commit, as well as files that Git does not track for changes (in this case, `./data/input.txt` since we've just created it and haven't `add`ed it yet). Any changes to files whose previous changes have been tracked by previous commits will also be listed in a separate category, "Changes not staged for commit."

### Committing staged changes

To create a new commit capturing your staged changes, use the `commit` subcommand with the `-m` option followed by a short message describing the contents of the commit in quotes:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git commit -m "changed toupper in test_script.R to tolower"
```

{: .important }
Because you can only look back in repository history commit by commit, **commit early and often.** Each commit should represent a small set of changes (e.g. adding a few new functions). Two nice guides on how to write informative commit messages are [here](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) and [here](https://cbea.ms/git-commit/).

To see the most recent few commits in reverse chronological order from the HEAD reference, use the `log` subcommand:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git log
commit 14e756a7835ad25afcb46932baa6ca441eacc5e2 (HEAD -> main)
Author: Brad Ross <brad.ross.35@gmail.com>
Date:   Tue Jul 16 00:53:09 2024 -0700

    changed toupper in test_script.R to tolower
...
```

## Branching

### Creating and changing branches

To create a new branch, use the `branch` subcommand with the name of the new branch as an argument:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git branch new_branch
```

Making a new branch doesn’t change the current branch; to list existing branches and see the current branch, run the `branch` subcommand with no arguments:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git branch
```

To change the current branch, use the `checkout` subcommand:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git checkout new_branch
```

Now that we're on a new branch, we'll change the `./src/test_script.R` file to replace spaces with underscores by replacing the line containing `tolower` with the following line:
```R
writeLines(gsub(" ", "_", input_contents), output_file)
```

To see the line-by-line changes that have been made to a particular file on the new branch, use the `diff` subcommand with a path to the file as an argument:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git diff src/test_script.R
```

Now, use `git status` to see that you haven’t yet staged this change, stage it with the `add` subcommand, and then create a commit with an informative commit message.

### Tracking parallel changes

To see how Git tracks parallel, competing changes, use the `checkout` subcommand to change the current branch back to the `main` branch and use Vim to see what the contents of `./src/test_script.R` are; what do you see?

Now use the `checkout` subcommand to change the current branch to `new_branch` once again and look at the contents of `./src/test_script.R`; what do you see now?

Being able to keep track of parallel changes to the same files is what makes version control software like Git so powerful.

Now, using the `status` or `branch` and `checkout` subcommands, make sure your current branch is `main,` and then modify `src/test_script.R` to instead replace spaces w/ `-`s by replacing the line containing `tolower` with the following line:
```R
writeLines(gsub(" ", "-", input_contents), output_file)
```

Once you’ve made this change, stage and commit it w/ an informative message.

### Merging branches

Sometimes, Git can automatically merge changes (e.g. if changes in each branch are in different files); other times, Git will show differences and ask you to resolve.

To merge the changes on another branch onto the current branch, use the `merge` subcommand with the name of the other branch to merge as an argument (before running the commmand below, make sure your current branch is `main`):
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git merge new_branch
```

After running this command, you should see the following message:
```bash
Auto-merging src/test_script.R
CONFLICT (content): Merge conflict in src/test_script.R
Automatic merge failed; fix conflicts and then commit the result.
```

Further, when you run `git status` after trying to conduct this branch merge, you should see the following message:
```bash
On branch main
You have unmerged paths.
    (fix conflicts and run "git commit")
    (use "git merge --abort" to abort the merge)

Unmerged paths:
    (use "git add <file> ... " to mark resolution)

        both modified:  src/test_script.R

...

no changes added to commit (use "git add" and/or "git commit -a")
```

Finally, when you open the `./src/test_script.R` file with Vim, you should see the following contents in the last few lines:
```R
output_file = file(file.path(OUTPUT_PATH, "output.txt"))
<<<<<<< HEAD
writeLines(gsub(" ", "_", input_contents), output_file)
=======
writeLines(gsub(" ", "-", input_contents), output_file)
>>>>>>>
close(output_file)
```

To resolve the merge conflict, just delete the version of the code associated with the commit at HEAD. Once you’ve chosen the version of the changes to `src/test_script.R` that you want to keep around, just stage `src/test_script.R` and then commit those changes to complete the merge. A good commit message is something like “merged new_branch onto master and resolved conflicts in favor of new_branch.” Resolving merge conflicts doesn’t have to be scary!

Git is a super powerful tool, and there’s a lot of functionality we didn’t have time to cover in this example (like how to actually undo changes). You can learn more by reading the first 5 chapters of [this free book](https://git-scm.com/book/en/v2) (it’s not too long!).

## .gitignore files

Git doesn’t handle large files (like data files) well, so it's better to not commit those; it's also better to not commit temporary output files that change upon script reruns, as well as sensitive information like files containing API credentials (especially in the age of companies using private data to train LLMs that are prone to regurgitating memorized training data).

In the context of our example project, it can be annoying to keep manually not committing “input.txt” and “output.txt” (and in real projects, the files these proxy for).

To solve these problems, create a new file `./.gitignore` with the following contents; the existence of this file with these contents will make Git ignore all `.txt` files in the `data` and `output` directories:
```
data/*.txt
output/*.txt
```

Now try staging all files in the repo by passing the `.` path to the `add` subcommand:
```bash
SUNetID@yen4:~/rf_bootcamp_2024/examples/day2/test_project$ git add .
```
You should see that only the `.gitignore` file gets staged, not `./data/input.txt`! Go ahead and commit these staged changes (as always, with an informative commit message).

We all make mistakes when using Git at some point, and that’s ok! The short guide, [Oh Shit, Git!?!](https://ohshitgit.com), can help you recover. To learn more about Git in a more compact source than some of the others we've already linked, you can also read more [here](https://missing.csail.mit.edu/2020/version-control/).