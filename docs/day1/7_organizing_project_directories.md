---
title: 7. Organizing Project Directories
layout: page
nav_order: 7
parent: Day 1
updateDate: 2024-07-10
---

# {{ page.title }}
---

Having learned the basics of how to interact with computers via the command line, we'll culminate Day 1 with some tips on how to organize project directories, as well as a final exercise to give you some practice in doing so

## Tips for keeping project directories organized

- Having all your data files, analysis code, intermediate/final analysis outputs, and paper code in the same directory gets messy quickly!

- Instead, it's generally good to create separate directories for different types of files; here’s an example of a simple directory structure that organizes research project files into three groups:
    - **data**: a folder containing all data files, with subdirectories for raw and processed data files
    - **src**: a folder containing all code, with subdirectories for data cleaning code, analysis code, and paper source code (e.g. LaTeX)
    - **output**: a folder to house code outputs, with subdirectories for intermediate (tables, figures) and final (compiled paper/slide drafts) outputs

- Everyone has their own system that works; the important thing is to keep code organized
    - read [here](https://web.stanford.edu/~gentzkow/research/CodeAndData.xhtml) for another high-level perspective on best practices for econs

## A culminating exercise

To practice good project directory hygiene, try doing the following cleanup of the “test_project” directory:
1. Create a directory called `test_project` in your ZFS home directory and create three subdirectories within it called `data`, `src`, and `output`
2. Use the `mv` command to move `~/input.txt` to the `data` directory and `~/test_script.R` to the `src` directory (use `rm` to delete the “output.txt” file you created earlier by running `~/test_script.R`)
    - `mv` commands are structured like so:
    ```bash
    SUNetID@yen4:~$ mv <Path-To-Source-File> <Path-To-Destination-File>
    ```
    where the paths `<Path-To-Source-File>` and `<Path-To-Destination-File>` should include the names of the files
3. Modify “test_script.R” so that when you run it from the top project directory `~/test_project`, it reads `input.txt` from the `data` directory and writes `output.txt` to the `output` directory.

## More best practices: code automation

- The code for most research analyses is spread across many files; running them manually in the right order and remembering to clean up old outputs beforehand is risky because humans make mistakes

- Better to automate using a shell script; use Vim to create a file `~/test_project/build.sh` with a shell command on each line that does your analysis tasks in the right order, i.e. with the folllowing contents:

```bash
#!/bin/bash

rm -r output/*
Rscript test_script.R
```

- The `#!/bin/bash` at the top of the file indicates to the computer that the lines of the file should be interpreted using the `bash` shell (the name of the kind of shell we've been using throughout today).

- To run the shell script, first use the `chmod` command to make the script executable, then use `./<SCRIPT_NAME>` to run it:
```bash
SUNetID@yen4:~/test_project$ chmod +x build.sh
SUNetID@yen4:~/test_project$ ./build.sh
```

- For more information about how to write richer shell scripts with more capabilities, see lesson [3](https://missing.csail.mit.edu/2020/shell-tools/) of MIT's Missing Semester course