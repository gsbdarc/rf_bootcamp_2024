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

## Setting up a repository from scratch

Once you're logged in to a Yen, either [change your working directory](/rf_bootcamp_2024/day1/2_directories_and_paths) to the `~/test_project` folder you created on Day 1 or [create a new directory](/rf_bootcamp_2024/day1/2_directories_and_paths) `~/test_project` and then change your working directory to it.

A Git repository is simply a folder with some additional metadata stored inside. To initialize a Git repository in a given directory (e.g. `~/test_project`), use the `init` subcommand of the `git` program from within the directory you want to turn into a Git repository:
```bash
SUNetID@yen4:~/test_project$ git init
```

Doing so creates a folder called `.git` inside the target directory that Git uses to store data for tracking changes. All files and folders whose names start with `.` are hidden by “ls” by default; use the “-a” flag to see them:
```bash
SUNetID@yen4:~/test_project$ ls -a
```

## Cloning a remote repository



## Creating a commit

