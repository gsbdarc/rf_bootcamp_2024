---
title: 6. Running Code on the Yens
layout: page
nav_order: 6
parent: Day 1
updateDate: 2024-07-10
---

# {{ page.title }}
---

- Before you run any code, you need some code to run; to get practice using Vim, open a new file called `test_script.R` in your ZFS home directory with Vim, write the following `R` code in it, and save it:

```R
INPUT_PATH = "~"
OUTPUT_PATH = "~"

input_file = file(file.path(INPUT_PATH, "input.txt"))
input_text = readLines(input_file)
close(input_file)

output_file = file(file.path(OUTPUT_PATH, "output.txt"))
writeLines(toupper(input_text), output_file)
close(output_file)
```

- Note that in the code above, we define `INPUT_PATH` and `OUTPUT_PATH` as separate constants, which is good practice when the input and output file paths might change depending on where the script is run (stay tuned for Day 4 when you'll learn how to write scripts that take in arguments on the command line).

- To run the script `~/test_script.R` with `R`, we first need to *load* our desired version of R into the shell on the Yen server using the `ml` command (short for `module load`):
```bash
SUNetID@yen4:~$ ml R
```

- To see what software packages whose names start with `R` (e.g. different `R` versions), you can use the `spider` **subcommand** of the `module` program:
```bash
SUNetID@yen4:~$ module spider R
```
    - When you load a program like `R` without specifying a software version, the default version is loaded (in this case, version 4.2.1 of `R`)
    - You can scroll down the returned list using the `d` key on your keyboard
    - If you run `module spider` with no arguments, you get a list of all available software packages
    - To load a specific version of a software package you want to load, run `ml <Program-Name>/<Version-Number>`, e.g. `ml R/4.2.1`

- Now, you can run the script `~/test_script.R` by passing a path to it as an argument to the `Rscript` command like so:
```bash
SUNetID@yen4:~$ Rscript test_script.R
```

- Use `ls` to see whether the script created a new file as intended, and, if so, open that file with Vim to see if the contents are what you expect.