---
title: Shell Extras
layout: page 
parent: Extras 
order: 0
updateDate: 2023-12-19
---

# {{ page.title }}
---

## Pipes and Filters
Now that we know a few basic commands, we can finally look at the shell’s most powerful feature: the ease with which it 
lets us combine existing programs in new ways. We’ll start with the `intro-to-yens/` directory that contains a text file 
`numbers.txt` that contains 1000 lines of randomly generated numbers from 1 to 10.

Let’s go into that directory with `cd` and run an example command `wc numbers.txt`:
 
 ```bash
$ cd ~/Desktop/intro-to-yens/
$ wc numbers.txt 
```

```bash
1000    1000    2086 numbers.txt
```
`wc` is the ‘word count’ command: it counts the number of lines, words, and characters in files (from left to right, 
in that order).

If we run `wc -l` instead of just `wc`, the output shows only the number of lines per file:
```bash
$ wc -l numbers.txt
```

```bash
1000 numbers.txt
```

#### Capturing output from commands
Which of these files contains the fewest lines? It’s an easy question to answer when there are only a few files, 
but what if there were 1000? Our first step toward a solution is to run the command:
```bash
$ wc -l *.txt > lengths.txt
```
The greater than symbol, `>`, tells the shell to redirect the command’s output to a file instead of printing it to the screen. 
(This is why there is no screen output: everything that `wc` would have printed has gone into the file `lengths.txt` instead.) 
The shell will create the file if it doesn’t exist. If the file exists, it will be silently overwritten, which may lead 
to data loss and thus requires some caution. `ls` confirms that the file exists:
```bash
$ ls
```

We can now send the content of `lengths.txt` to the screen using `cat lengths.txt`. The `cat` command gets its name from 
‘concatenate’ i.e. join together, and it prints the contents of files one after another. There’s only one file in this case, 
so `cat` just shows us what it contains:
```bash
$ cat lengths.txt
```

```bash
    1000 numbers.txt
    3000 numbers2.txt
     500 numbers3.txt
    4500 total
```

#### Filtering output
Next we’ll use the `sort` command to sort the contents of the `lengths.txt` file. Note that
`sort -n` option specifies a numerical rather than an alphanumerical sort. `sort` does not change the file; instead, 
it sends the sorted result to the screen:
```bash
$ sort -n lengths.txt
```

```bash
     500 numbers3.txt
    1000 numbers.txt
    3000 numbers2.txt
    4500 total
```
We can put the sorted list of lines in another temporary file called `sorted-lengths.txt` by putting `> sorted-lengths.txt`
after the command, just as we used `> lengths.txt` to put the output of `wc` into `lengths.txt`. Once we’ve done that, 
we can run another command called `head` to get the first few lines in `sorted-lengths.txt`:

```bash
$ sort -n lengths.txt > sorted-lengths.txt
$ head -n 1 sorted-lengths.txt
```

```bash
500 numbers3.txt
```
Using `-n 1` with `head` tells it that we only want the first line of the file; `-n 20` would get the first 20, and so on. 
Since `sorted-lengths.txt` contains the lengths of our files ordered from least to greatest, the output of `head -n 1` 
must be the file with the fewest lines.

The `head` command prints lines from the start of a file. `tail` is similar, but prints lines from the end of a file instead.

Note, it’s a very bad idea to try redirecting the output of a command that operates on a file to the same file. 
Doing something like this may give you incorrect results and/or delete the contents of the file.

We have seen the use of `>`, but there is a similar operator `>>` which works slightly differently. 
We’ll learn about the differences between these two operators by printing some strings. We can use the `echo` command 
to print strings 
```bash
$ echo hello
```

Run each command twice to see the difference between the two operators:
```bash
$ echo hello > testfile01.txt
```

```bash
$ echo hello >> testfile02.txt
```
Examine the output files. The `>>` operator appends to the file if it already exists instead of overwriting the file as `>` does. 

#### Passing output to another command
In our example of finding the file with the fewest lines, we are using two intermediate files to store output. 
This is a confusing way to work because even once you understand what `wc`, `sort`, and `head` do, those intermediate 
files make it hard to follow what’s going on. We can make it easier to understand by running `sort` and `head` together:
```bash
$ sort -n lengths.txt | head -n 1
```

```bash
500 numbers3.txt
```
The vertical bar, `|`, between the two commands is called a **pipe**. It tells the shell that we want to use the output 
of the command on the left as the input to the command on the right. This has removed the need for the `sorted-lengths.txt` file.

A **filter** is a program like `wc` or `sort` that transforms a stream of input into a stream of output. 
Almost all of the standard Unix tools can work this way: unless told to do otherwise, they read from standard input, 
do something with what they’ve read, and write to standard output.

#### Combining multiple commands
Nothing prevents us from chaining pipes consecutively. We can for example send the output of `wc` directly to `sort`, 
and then the resulting output to `head`. This removes the need for any intermediate files.

```bash
$ rm lengths.txt sorted-lengths.txt
```

We’ll start by using a pipe to send the output of `wc` to `sort`:

```bash
$ wc -l *.txt | sort -n 
```

```bash
     500 numbers3.txt
    1000 numbers.txt
    3000 numbers2.txt
    4500 total
```
We can then send that output through another pipe, to `head`, so that the full pipeline becomes:

```bash
$ wc -l *.txt | sort -n | head -n 1
```

```bash
500 numbers3.txt
```

#### Summary
- `wc` counts lines, words, and characters in its inputs.
- `cat` displays the contents of its inputs.
- `sort` sorts its inputs.
- `head` displays the first 10 lines of its input.
- `tail` displays the last 10 lines of its input.
- `command > [file]` redirects a command’s output to a file (overwriting any existing content).
- `command >> [file]` appends a command’s output to a file.
- `[first] | [second]` is a pipeline: the output of the first command is used as the input to the second.
- The best way to use the shell is to use pipes to combine simple single-purpose programs (filters).

## Loops
**Loops** are a programming construct which allow us to repeat a command or set of commands for each item in a list. 
As such they are key to productivity improvements through automation. Similar to wildcards and tab completion, using 
loops also reduces the amount of typing required (and hence reduces the number of typing mistakes).

Suppose we would like to print out the number on the tenth line for each text file in `intro-to-yens` directory. For each file, 
we would need to execute the command `head` and pipe this to `tail -n 1`. We’ll use a loop to solve this problem, 
but first let’s look at the general form of a loop:

```bash
for thing in list_of_things
do
    operation_using $thing    # Indentation within the loop is not required, but aids legibility
done
```
and we can apply this to our example like this:
```bash
$ for filename in numbers.txt numbers2.txt numbers3.txt
> do
>     head $filename | tail -n 1
> done
```

```
2
2
10
```
The shell prompt changes from `$` to `>` and back again as we were typing in our loop. The second prompt, `>`, 
is different to remind us that we haven’t finished typing a complete command yet. A semicolon, `;`, can be used to 
separate two commands written on a single line.

When the shell sees the keyword `for`, it knows to repeat a command (or group of commands) once for each item in a list. 
Each time the loop runs (called an iteration), an item in the list is assigned in sequence to the **variable**, and the 
commands inside the loop are executed, before moving on to the next item in the list. Inside the loop, we call for the 
variable’s value by putting `$` in front of it. The `$` tells the shell interpreter to treat the variable as a variable 
name and substitute its value in its place, rather than treat it as text or an external command.

When using variables it is also possible to put the names into curly braces to clearly delimit the variable name: 
`$filename` is equivalent to `${filename}`. You may find this notation in other people’s programs.

Here’s a slightly more complicated loop:
```bash
$ for filename in *.txt
> do
>     echo $filename
>     head $filename | tail -n 1
> done
```

```bash
numbers.txt
2
numbers2.txt
2
numbers3.txt
10
```
The shell starts by expanding `*.txt` to create the list of files it will process. The **loop body** then executes two
 commands for each of those files. The first command, `echo`, prints its command-line arguments (the name of the file) 
 to standard output. Then, the `head` and `tail` combination selects tenth line from each file. 
 
Another way to repeat previous work is to use the `history` command to get a list of the last few hundred commands 
that have been executed, and then to use `!123` (where `‘123’` is replaced by the command number) to repeat one of 
those commands.

#### Summary
- A `for` loop repeats commands once for every thing in a list.
- Every `for` loop needs a variable to refer to the thing it is currently operating on.
- Use `$name` to expand a variable (i.e., get its value). `${name}` can also be used.
- Use `history` to display recent commands, and `![number]` to repeat a command by number.

## Finding Things
In the same way that many of us now use ‘Google’ as a verb meaning ‘to find’, Unix programmers often use the word `grep`. 
`grep` is a contraction of ‘global/regular expression/print’, a common sequence of operations in early Unix text editors. 
It is also the name of a very useful command-line program.

`grep` finds and prints lines in files that match a pattern. For our example, we will use a file 
`swiss-parallel-bootstrap.R` containing bootstrapping code in `intro-to-yens` directory.

```bash
$ grep ncore swiss-parallel-bootstrap.R
``` 

```bash
ncore <- detectCores()
print(paste('running on', ncore, 'cores'))
# register parallel backend to limit threads to the value specified in ncore variable
registerDoParallel(ncore)
```

Here, `ncore` is the pattern we’re searching for. The `grep` command searches through the file, looking for matches to 
the pattern specified. To use it type `grep`, then the pattern we’re searching for and finally the name of the file (or files) 
we’re searching in.

The output is the four lines in the file that contain the letters `ncore`.

By default, `grep` searches for a pattern in a case-sensitive way. 

A useful option is `-n`, which numbers the lines that match:

```bash
$ grep -n ncore swiss-parallel-bootstrap.R
```

```bash
9:ncore <- detectCores()
11:print(paste('running on', ncore, 'cores'))
13:# register parallel backend to limit threads to the value specified in ncore variable
14:registerDoParallel(ncore)
```
Here, we can see that lines 9, 11, 13 and 14 contain the letters `ncore`.

If we use the `-r` (recursive) option, `grep` can search for a pattern recursively through a set of files in subdirectories.

While `grep` finds lines in files, the `find` command finds files themselves. 

Let’s run `find .`. Remember to run this command from the `intro-to-yens` directory.

```bash
$ find .
```
As always, the `.` on its own means the current working directory, which is where we want our search to start. 
`find`’s output is the names of every file and directory under the current working directory. 

Now let’s try matching by name:

```bash
$ find . -name "*.txt"
```
Put `*.txt` in quotes to prevent the shell from expanding the `*` wildcard. This command gives us a list of all text files 
in or below the current directory.

How can we combine that with `wc -l` to count the lines in all those files?

The simplest way is to put the `find` command inside `$()`:

```bash
$ wc -l $(find . -name "*.txt")
```
When the shell executes this command, the first thing it does is run whatever is inside the `$()`. 
It then replaces the `$()` expression with that command’s output. 

#### Summary
- `find` finds files with specific properties that match patterns.
- `grep` selects lines in files that match patterns.
- `$([command])` inserts a command’s output in place.

## Shell Scripts
We are finally ready to see what makes the shell such a powerful programming environment. We are going to take the 
commands we repeat frequently and save them in files so that we can re-run all those operations again later by typing a 
single command. For historical reasons, a bunch of commands saved in a file is usually called a **shell script**.

We can put the `for` loop we wrote earlier in a shell script called `print_tenth_line.sh`.

The shell script should contain:

```bash
for filename in *txt
do
    echo $filename
    head $filename | tail -n 1
done
```

Once we have saved the file, we can ask the shell to execute the commands it contains. Our shell is called `bash`, 
so we run the following command:

```bash
$ bash print_tenth_line.sh
```

```bash
numbers.txt
2
numbers2.txt
2
numbers3.txt
10
```
Sure enough, our script’s output is exactly what we would get if we ran that loop directly.
