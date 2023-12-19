---
title: The Unix Shell
layout: page 
nav_order: 2
parent: Prerequisites
updateDate: 2023-12-19
---

# {{ page.title }}
---
The Unix shell has been around longer than most of its users have been alive. It has survived because it’s a powerful tool that allows users to perform complex tasks, 
often with just a few keystrokes or lines of code. It helps users automate repetitive tasks and easily combine smaller tasks into larger, more powerful workflows.

Use of the shell is fundamental to a wide range of advanced computing tasks, including high-performance computing. This lesson will introduce you to this powerful new tool.

## Introducing the shell

Humans and computers commonly interact in many different ways, such as through a keyboard and mouse, touch screen interfaces, 
or using speech recognition systems. The most widely used way to interact with personal computers is called a **graphical user interface** (GUI). 
With a GUI, we give instructions by clicking a mouse and using menu-driven interactions.

While the visual aid of a GUI makes it intuitive to learn, this way of delivering instructions to a computer scales very poorly. 
Imagine the following task: for a literature search, you have to copy the third line of one thousand text files in one thousand different directories 
and paste it into a single file. Using a GUI, you would not only be clicking at your desk for several hours, 
but you could potentially also commit an error in the process of completing this repetitive task. 
This is where we take advantage of the Unix shell. The Unix shell is both a **command-line interface** (CLI) and a scripting language, 
allowing such repetitive tasks to be done automatically and fast. With the proper commands, the shell can repeat tasks with 
or without some modification as many times as we want. Using the shell, the task in the literature example can be accomplished in seconds.

## The Shell

The shell is a program where users can type commands. With the shell, it’s possible to invoke complicated programs like 
machine learning training program or simple commands that create an empty directory with only one line of code. The most popular 
Unix shell is Bash (the Bourne Again SHell — so-called because it’s derived from a shell written by Stephen Bourne). 
Bash is the default shell on most modern implementations of Unix and in most packages that provide Unix-like tools for Windows.

Using the shell will take some effort and some time to learn. While a GUI presents you with choices to select, 
CLI choices are not automatically presented to you, so you must learn a few commands like new vocabulary in a language you’re studying. 
However, unlike a spoken language, a small number of “words” (i.e. commands) gets you a long way.

The grammar of a shell allows you to combine existing tools into powerful pipelines and handle large volumes of data automatically. 
Sequences of commands can be written into a *script*, improving the reproducibility of workflows.

In addition, the command line is often the easiest way to interact with remote machines and supercomputers. 
Familiarity with the shell is near essential to run a variety of specialized tools and resources including high-performance computing systems. 
As clusters and cloud computing systems become more popular, being able to interact with the shell is becoming a necessary skill. 

Let’s get started.

Open a Terminal App (Mac) or MobaXterm (Windows) terminal. A terminal presents you with a text-based interface to interact with the shell.
 
When the shell is first opened, you are presented with a **prompt**, indicating that the shell is waiting for input.

```bash
$ 
```

The shell typically uses `$` as the prompt, but may use a different symbol. Importantly, when typing commands, 
*do not type the prompt*, only the commands that follow it. Also note that after you type a command, you have to press 
the `Enter` key to execute it.

The prompt is followed by a **text cursor**, a character that indicates the position where your typing will appear. 
The cursor is usually a flashing or solid block, but it can also be an underscore or a pipe.

So let’s try our first command, `ls` which is short for listing. 

```bash
$ ls
```

This command will list the contents of the current directory:
```
Applications	Downloads	Movies		Public		opt		rcpediatwo
Desktop		Google Drive	Music		pearc21		slurm_lambda
Documents	Library		    Pictures	projects
```

If the shell can’t find a program whose name is the command you typed, it will print an error message such as:

```bash
$ ks
ks: command not found
```
This might happen if the command was mistyped or if the program corresponding to that command is not installed.

#### Summary
- A shell is a program whose primary purpose is to read commands and run other programs.
- This lesson uses Bash, the default shell in many implementations of Unix.
- Programs can be run in Bash by entering commands at the command-line prompt.
- The shell’s main advantages are its high action-to-keystroke ratio, its support for automating repetitive tasks, and its capacity to access networked machines.
- The shell’s main disadvantages are its primarily textual nature and how cryptic its commands and operation can be.


## Navigating File and Directories
The part of the operating system responsible for managing files and directories is called the **file system**. It organizes
 our data into files, which hold information, and directories (also called ‘folders’), which hold files or other directories.

Several commands are frequently used to create, inspect, rename, and delete files and directories. 

First, let’s find out where we are by running a command called `pwd` (which stands for ‘print working directory’). 
Directories are like *places* — at any time while we are using the shell, we are in exactly one place called our 
**current working directory**. Commands mostly read and write files in the current working directory, i.e. ‘here’, 
so knowing where you are before running a command is important. `pwd` shows you where you are:

```bash
$ pwd
```
```bash
/Users/nrapstin
```
which is my **home directory**.

The home directory path will look different on different operating systems.

To understand what a ‘home directory’ is, let’s have a look at how the file system as a whole is organized. 

On my local computer, the filesystem looks like:

![](/intro-to-yens/assets/images/home-dir-local-machine.png)

At the top is the root directory that holds everything else. We refer to it using a slash character, `/`, on its own; 
this character is the leading slash in `/Users/nrapstin`.

Inside that directory are several other directories: `bin` (which is where some built-in programs are stored), 
`Users` (where users’ personal directories are located), `tmp` (for temporary files that don’t need to be stored long-term), 
and so on.

We know that our current working directory `/Users/nrapstin` is stored inside `/Users` because `/Users` is the first part of its name. 
Similarly, we know that `Users` is stored inside the root directory `/` because `/Users` path begins with `/`.

Notice that there are two meanings for the `/` character. When it appears at the front of a file or directory name, 
it refers to the root directory. When it appears *inside* a path, it’s just a separator.

Underneath `/Users`, we find users' home directories. Thus, my files are stored in `/Users/nrapstin` which is my home directory.


We've already used `ls` command to see what's in our home directory:

```bash
$ ls
``` 

```bash
Applications	Downloads	Movies		Public		opt		rcpediatwo
Desktop		Google Drive	Music		pearc21		slurm_lambda
Documents	Library		    Pictures	projects
```

(Again, your results may be slightly different depending on your operating system and how you have customized your filesystem.)

`ls` prints the names of the files and directories in the current directory. We can make its output more comprehensible by using 
the `-F` **option** (also known as a **switch** or a **flag**), which tells `ls` to classify the output by adding a marker 
to file and directory names to indicate what they are:
- a trailing `/` indicates that this is a directory
- `@` indicates a link
- `*` indicates an executable

```bash
$ ls -F
``` 

Depending on your default options, the shell might also use colors to indicate whether each entry is a file or directory.

```bash
Applications/	Downloads/	Movies/		Public/		opt/		rcpediatwo/
Desktop/	Google Drive@	Music/		pearc21/	slurm_lambda/
Documents/	Library/	    Pictures/		projects/
```

Here, we can see that our home directory contains **subdirectories**. Any names in our output that don’t have a classification symbol are plain old **files**.
 
If your screen gets too cluttered, you can clear your terminal using the `clear` command. You can still access previous commands using `↑` and `↓`.

#### Getting Help
`ls` has lots of other **options**. To find out how to use a command and what options it accepts, we can read its manual with a `man` command: 

```bash
$ man ls
```

This command will turn your terminal into a page with a description of the `ls` command and its options.

To navigate through the man pages, you may use `↑` and `↓` to move line-by-line, or try `B` and `Spacebar` to skip up and down by a full page. 
To quit the man pages, press `q`.

If you try to use an option (flag) that is not supported, `ls` and other commands will usually print an error message similar to:

```bash
$ ls -j
```

```
ls: invalid option -- 'j'
```

You can also use two or more options at the same time. What does the command `ls` do when used with the `-l` option? 
What about if you use both the `-l` and the `-h` option?

```
$ ls -l
```
The `-l` option makes `ls` use a **l**ong listing format, showing not only the file/directory names but also additional information, 
such as the file size and the time of its last modification.

```
$ ls -lh
```
If you use both the `-h` option and the `-l` option, this makes the file size ‘**h**uman readable’, i.e. displaying something like `1.9K` instead of `1984`.

Note that in most command line tools, multiple options can be combined with a single `-` and no spaces between the options: `ls -l -h` is equivalent to `ls -lh`.

By default, `ls` lists the contents of a directory in alphabetical order by name. The command `ls -t` lists items by 
time of last change instead of alphabetically. 
The command `ls -r` lists the contents of a directory in reverse order. Which file is displayed last when you combine 
the `-l`, `-t` and `-r` flags? 

```bash
$ ls -ltr
```
The most recently changed file is listed last when using `-ltr`. This can be very useful for finding your most recent edits 
or checking to see if a new output file was written.

#### Exploring Other Directories
Not only can we use `ls` on the current working directory, but we can use it to list the contents of a different directory.
Let’s take a look at our `Desktop` directory by running `ls -F Desktop`, i.e., the command `ls` with the `-F` **option** and 
the **argument** `Desktop`. The argument Desktop tells `ls` that we want a listing of something other than our current working directory:

```bash
$ ls -F Desktop
```
Note that if a directory named `Desktop` does not exist in your current working directory, this command will return an error. 

Your output should be a list of all the files and subdirectories in your `Desktop` directory.

```bash
intro-to-yens/
```
Now that we know the `intro-to-yens` directory is located in our `Desktop` directory, we can do two things.

First, we can look at its contents, using the same strategy as before, passing a directory name to `ls`:

```bash
$ ls -F Desktop/intro-to-yens
```

Second, we can actually change our location to a different directory, so we are no longer located in our home directory.

The command to change locations is `cd` followed by a directory name to change our working directory. `cd` stands for ‘change directory’.

Let’s say we want to move to the `intro-to-yens` directory we saw above. We can use the following series of commands to get there:

```
$ cd Desktop
$ cd intro-to-yens
```

These commands will move us from our home directory into our `Desktop` directory, then into the `intro-to-yens` directory.
You will notice that `cd` doesn’t print anything. This is normal. Many shell commands will not output anything to the 
screen when successfully executed. But if we run `pwd` after it, we can see that we are now in `/Users/nrapstin/Desktop/intro-to-yens`.

```bash
$ pwd
```

```
/Users/nrapstin/Desktop/intro-to-yens
```

If we run `ls -F` without arguments now, it lists the contents of `/Users/nrapstin/Desktop/intro-to-yens`, because that’s where we now are:

```bash
numbers.txt			numbers3.txt			shell-novice/
numbers2.txt		print_tenth_line.sh		investment-npv-parallel.R
```

We now know how to go down the directory tree (i.e. how to go into a subdirectory), but how do we go up 
(i.e. how do we leave a directory and go into its parent directory)? With our methods so far, `cd` can only see subdirectories 
inside your current directory. There are different ways to see directories above your current location; we’ll start with the simplest.

There is a shortcut in the shell to move up one directory level that looks like this:

```bash
$ cd ..
```
`..` is a special directory name meaning “the directory containing this one”, or more succinctly, the **parent** of the current directory. 
Sure enough, if we run `pwd` after running `cd ..`, we’re back in `/Users/nrapstin/Desktop`:

```bash
$ pwd
```

```
/Users/nrapstin/Desktop
```

The special directory `..` doesn’t usually show up when we run `ls`. If we want to display it, we can add the `-a` option to `ls -F`:

```bash
$ ls -Fa
```

```
./          intro-to-yens/
../
```

`-a` stands for ‘show all’; it forces `ls` to show us file and directory names that begin with `.`, such as `..`.
As you can see, it also displays another special directory that’s just called `.`, which means ‘the current working directory’.

The special names `.` and `..` don’t belong to `cd`; they are interpreted the same way by every program. 
For example, if we are in `/Users/nrapstin`, the command `ls ..` will give us a listing of `/Users`. 

These three commands are the basic commands for navigating the filesystem on your computer: `pwd`, `ls`, and `cd`. Let's
see what happens if you type `cd` on its own, without giving a directory?

```bash
$ cd
```
How can you check what happened? `pwd` gives us the answer!

```bash
$ pwd
```

```
/Users/nrapstin
```
It turns out that `cd` without an argument will return you to your home directory, which is great if you’ve gotten lost in your own filesystem.

Let’s try returning to the `intro-to-yens` directory from before. Last time, we used two commands, but we can actually 
string together the list of directories to move to in one step:

```bash
$ cd Desktop/intro-to-yens/
```
Check that we’ve moved to the right place by running `pwd` and `ls -F`.

If we want to move up one level from the `intro-to-yens` directory, we could use `cd ..`. 
But there is another way to move to any directory, regardless of your current location.

So far, when specifying directory names, or even a directory path (as above), we have been using **relative paths**. 
When you use a relative path with a command like `ls` or `cd`, it tries to find that location from where we are, 
rather than from the root of the file system.

However, it is possible to specify the **absolute path** to a directory by including its entire path from the root directory, 
which is indicated by a leading slash. The leading `/` tells the computer to follow the path from the root of the file system, 
so it always refers to exactly one directory, no matter where we are when we run the command.

This allows us to move to our `Desktop` directory from anywhere on the filesystem (including from inside `intro-to-yens`).
To find the absolute path we’re looking for, we can use `pwd` and then extract the piece we need to move to `Desktop`.

```bash
$ pwd
```

```bash
/Users/nrapstin/Desktop/intro-to-yens
```

```bash
$ cd /Users/nrapstin/Desktop/
```

Run `pwd` and `ls -F` to ensure that we’re in the directory we expect.

#### Two more shortcuts
The shell interprets a tilde (`~`) character at the start of a path to mean “the current user’s home directory”. 
For example, if my home directory is `/Users/nrapstin`, then `~/Desktop` is equivalent to `/Users/nrapstin/Desktop`. 

Another shortcut is the `-` (dash) character. `cd` will translate `-` into *the previous directory I was in*, 
which is faster than having to remember, then type, the full path. This is a very efficient way of moving back and forth between two directories – 
i.e. if you execute `cd -` twice, you end up back in the starting directory.

If a command is a lot to type (like a long path), we can let the shell do most of the work through what is called **tab completion**. 
If we type:

```bash
$ ls ~/Desktop/i
```
and then press `Tab`, the shell automatically completes the directory name:

```bash
ls ~/Desktop/intro-to-yens/
```

If there is one possible match inside a subdirectory, pressing `Tab` again will add that file or directory name automatically.  
If pressing `Tab` again does nothing, there is more than one possible match. Pressing `Tab` twice brings up a list of all the files/directories that match what we typed. 
 
#### Summary
- The file system is responsible for managing information on the disk.
- Information is stored in files, which are stored in directories (folders).
- Directories can also store other directories, which then form a directory tree.
- `cd [path]` changes the current working directory.
- `ls [path]` prints a listing of a specific file or directory; `ls` on its own lists the current working directory.
- `pwd` prints the user’s current working directory.
- `/` on its own is the root directory of the whole file system.
- Most commands take options (flags) that begin with a `-`.
- A relative path specifies a location starting from the current location.
- An absolute path specifies a location from the root of the file system.
- Directory names in a path are separated with `/` on Unix.
- `..` means ‘the directory above the current one’; `.` on its own means ‘the current directory’.




## Working With Files and Directories

#### Creating directories

Let’s return to `intro-to-yens` directory first, then navigate to `shell-novice` subdirectory and create a new directory 
called `test` using the command `mkdir test`:

```bash
$ cd intro-to-yens
$ cd shell-novice 
$ mkdir test
```
As you might guess from its name, `mkdir` means ‘make directory’. Since `test` is a relative path 
(i.e., does not have a leading slash, like `/what/ever/test`), the new directory is created in the current working directory.


Complicated names of files and directories can make your life painful when working on the command line. 
Here are a few useful tips for the names of your files and directories.

- Don’t use spaces. Spaces can make a name more meaningful, but since spaces are used to separate arguments on the command line
 it is better to avoid them in names of files and directories. You can use `-` or `_` instead. 
 
- Don’t begin the name with `-`. Commands treat names starting with `-` as options.

- Stick with letters, numbers, `.`, `-` and `_`. Many other characters have special meanings on the command line. 

If you need to refer to names of files or directories that have spaces or other special characters, you should surround the name in quotes (`""`).

To create an empty text file, you can use the `touch` command:

```bash
$ touch test.txt
```

#### Moving files and directories
We can rename a file by using `mv` command which is short for ‘move’:
```bash
$ mv test.txt empty_file.txt
```
The first argument tells `mv` what we’re ‘moving’, while the second is where it’s to go.

One must be careful when specifying the target file name, since `mv` will silently overwrite any existing file with 
the same name, which could lead to data loss. 

`mv` also works on directories.

Let’s move `empty_file.txt` into the `test` directory. We use `mv` again, but this time we’ll use just the name 
of a directory as the second argument to tell `mv` that we want to keep the filename but put the file somewhere new.

```bash
$ mv empty_file.txt test 
```

Run `ls` on `test` to confirm that the file is there.

```bash
$ ls test
```

#### Copying files and directories
The `cp` command works very much like `mv`, except it copies a file instead of moving it. 

```bash
$ cp test/empty_file.txt test2.txt 
```

We can also copy a directory and all its contents by using the recursive option `-r`:
```bash
$ cp -r test test_backup
```
We can check the result by listing the contents of both the `test` and `test_backup` directories:
```bash
$ ls test test_backup/ 
```

```bash
test:
empty_file.txt

test_backup/:
empty_file.txt
```

#### Removing files and directories
Let’s tidy up this directory by removing the `test2.txt` file we created. 
The Unix command we’ll use for this is `rm` (short for ‘remove’):

```bash
$ rm test2.txt
```

We can confirm the file is gone using `ls`:
```bash
$ ls test2.txt
```

```
ls: cannot access 'test2.txt': No such file or directory
```

**Deleting Is Forever**
The Unix shell doesn’t have a trash bin that we can recover deleted files from (though most graphical interfaces to Unix do). 
Instead, when we delete files, they are unlinked from the file system so that their storage space on disk can be recycled. 
Tools for finding and recovering deleted files do exist, but there’s no guarantee they’ll work in any particular situation, 
since the computer may recycle the file’s disk space right away.

If we try to remove the `test` directory using `rm test`, we get an error message:
```bash
$ rm test
```

```
rm: cannot remove `test': Is a directory
```
This happens because `rm` by default only works on files, not directories.

`rm` can remove a directory and all its contents if we use the recursive option `-r`, and it will do so without any confirmation prompts:

```bash
$ rm -r test
$ rm -r test_backup
```

#### Operations with multiple files and directories

Often one needs to copy or move several files at once. This can be done by providing a list of individual filenames, 
or specifying a naming pattern using wildcards.

```bash
$ cd data
$ mkdir backup
$ cp test2.txt test3.txt backup
```

```bash
$ ls backup
```

```bash
test2.txt	test3.txt
```

If given more than one file name followed by a directory name (i.e. the destination directory must be the last argument), 
`cp` copies the files to the named directory.

`*` is a **wildcard**, which matches zero or more characters. Let’s consider the `intro-to-yens/shell-novice/data` directory: 
`*.txt` matches `test1.txt`, `test2.txt`, and every file that ends with `.txt`.

```bash
$ mv *txt backup
```
In the above, the shell will expand `*.txt` to match all `.txt` files in the current directory. The `mv` command then
 moves the list of `.txt` files to the `backup` directory.
 
#### Summary
- `cp [old] [new]` copies a file.
- `mkdir [path]` creates a new directory.
- `mv [old] [new]` moves (renames) a file or directory.
- `rm [path]` removes (deletes) a file.
- `*` matches zero or more characters in a filename, so `*.txt` matches all files ending in `.txt`.
- The shell does not have a trash bin: once something is deleted, it’s really gone.
- Most files’ names are `something.extension`. The extension isn’t required, and doesn’t guarantee anything, 
but is normally used to indicate the type of data in the file.
---
