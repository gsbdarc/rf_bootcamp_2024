---
title: 4. Moving and Managing Larger Files
layout: page
nav_order: 4
parent: Day 2
updateDate: 2024-07-10
---

# {{ page.title }}
---

Often, you’ll be downloading and moving large (>1GB) files (often data) between folders on a computer or even between computers; Git is not designed to handle versioning these large files, so it's worth talking about best practices for both handling these files and keeping track of changes to them.

## Moving files (between machines)

- There are many tools to move files between machines, but today we’ll be focusing on two: `scp` and [`rclone`](https://rclone.org)
- First, we will show you how to copy files to and from your laptop using `scp`
    - `scp` is useful for uploading data downloaded from the Internet to your local computer or for downloading tables, figures, or compiled paper drafts to view on your computer
- Then we will show you how to copy large files around the Yens (and from third-party cloud storage like Dropbox, Box, Google Drive) using the more efficient `rclone`

### Copying files to/from the Yens using `scp`

- Download the file I put [here](https://bit.ly/3cwKWJ5) to your your laptop

- Open a new terminal window on your local computer (different from the one connected to the Yens) and change your current working directory to where you downloaded the file
    - On Macs, downloads go to the Downloads folder by default, which has path `~/Downloads`

- Upload the file using the `scp` command with two arguments: (1) local path of the file you want to upload; (2) the remote address (before `:`) and path on the remote (after `:`):
```bash
machine_name:~/Downloads$ scp input.txt SUNetID@yen.stanford.edu:~/rf_bootcamp_2024/examples/day2/test_project/data/input.txt
```

- What’s in your “test_project” directory on the Yens now? Use `ls` and `vim` to see...

- To copy a whole directory between computers using `scp`, use the -r flag (similar to deleting whole directories w/ `rm`); for example, to copy the `~/rf_bootcamp_2024/examples/day2/test_project` directory from your home directory on the Yens to your current working directory on your local computer, run the following command from your local terminal (not on the Yens):
```bash
machine_name:~/Downloads$ scp -r SUNetID@yen.stanford.edu:~/rf_bootcamp_2024/examples/day2/test_project test_project
```

- Confirm that the contents of the `test_project` folder you just downloaded match the contents of the directory on the Yens.

### Copying large files with `rclone`

- [Rclone](https://rclone.org) is a program (already installed on the Yens) that copies files efficiently from either other directories on the Yens or third-party cloud storage providers.

- To use `rclone` on the Yens, first load the `rclone` module using the `ml` command (See [this page](/rf_bootcamp_2024/day1/6_running_code) from Day 1 for a refresher)

- Rclone’s `copy` subcommand copies the contents of the first argument (a path) to the inside of the second argument (also a path):
```bash
SUNetID@yen4:~$ rclone copy <Path-To-Source-Directory> <Path-To-Destination-Directory>
```

- We won’t have time to do this today, but can also configure rclone to move files to and from Dropbox, Box, Google Drive, etc.
    - More instructions for how to do so (and get the most from `rclone` in general) can be found [here](https://rclone.org/docs/)
    - To do so, you'll need to learn more about how to get permission to interact w/ these third-party cloud storage providers programmatically via what are called API (Application Programming Interface) keys

## Best practices for keeping track of data changes

- Hopefully, saw that when you `scp`'ed a file from your local machine to the Yens, you were replacing original `input.txt`; if this were your actual data for a project, this could break your existing analyses!

- Usually best to instead copy the new data to your project directory under a new name (by changing the destination path you pass to scp/rclone). It's usually best practice to name these data files based on something like a creation date or version number so you can keep track of which versions of data are which.

- It can also be helpful to create a text file called `README.txt` that you always update to contain the most recent time when the data files were updated and where they were downloaded from (if downloaded from external sources)
    - You can also use a Markdown file format (`README.md`, as seen in the Git repository `~/rf_bootcamp_2024/examples/day2/test_project`), which allows lightweight text formatting (e.g. surrounding text with `*`s italicizes that text); a simple guide can be found [here](https://www.markdownguide.org/getting-started/).

- Recently, some faculty have started hosting their data on [Redivis](https://redivis.com), which is a research-oriented data platform that automatically keeps track of versions of your data and allows you to query your data via SQL; they also have very nice python and R libraries that allow you to download data from their servers to the Yens.