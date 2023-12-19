---
title: 6. Yen File System 
layout: page 
parent: Topics 
nav_order: 6
updateDate: 2023-12-19
---

# {{ page.title }}
---
If you are new to using the Unix shell, please go over the <a href="/gettingStarted/shell_novice.html" target="_blank">Shell Introduction</a>
first.
 
If you’re already comfortable manipulating files and directories (using `ls`, `pwd`, `cd`, `mv`, `rm` commands), 
you probably want to explore the next lesson: <a href="/gettingStarted/shell_extras.html" target="_blank">Shell Extras</a>, 
to learn about searching for files with `grep` and `find`, and writing simple shell loops and scripts.
 
### Home Directory
Every user on the Yens has a home directory. This is where you are when you login to the system.
Check the absolute path with:

```bash
$ pwd
```

This will print your working directory (where `<SUNetID>` is your SUNet ID):

```bash
/home/users/<SUNetID>
```

To see this schematically, here is a visualization of the home directory on the file system:


![](/images/intro_to_yens/home-dir.png)

The squares with `...` in them indicate more directories that are not shown in the graph.

The path to your home directory is stored in `$HOME` environment variable. To see it, run:

```bash
$ echo $HOME
```

The `echo` command prints out the environment variable `$HOME` which stores the path to your home directory 
(where `<SUNetID>` is your SUNet ID):

```bash
/home/users/<SUNetID>
```

The home directory is not for storing large files or outputting large files while working on a project. It is a good place to store small
files like scripts and text files. Your home directory storage space is capped at 50 G.  

To see how much space you have used in your home directory, run:

```bash
$ gsbquota
```

You should see your home directory usage:

```bash
/home/users/<SUNetID>: currently using X% (XG) of 50G available
```
where `X%` and `XG` will be actual percent used and gigabytes used, respectively.

## File Storage

You have several options for where to store your research files (data sets, programs, output files, and so forth). 

### ZFS Directories

The GSB now has nearly 1 PB of high-performance storage available from the yen servers under the path ```/zfs```. 

{% include tip.html content="ZFS is mounted only from the yen servers. You cannot access it from Sherlock, FarmShare or any other system." %}

### Project Directory

If you are a GSB researcher that is interested in starting a new project on the Yens,
please complete and submit DARC’s new <a href="http://darc.stanford.edu/yenstorage" target="_blank">project request form</a>.
This form allows you to estimate disk usage, and specify any collaborators that should be added to the shared access list.
ZFS project access is granted by <a href="/yen/workgroups.html" target="_blank">workgroups</a>.

The project directories on ZFS have much bigger quotas (1 T default). However, we ask that you be responsible and
delete what you no longer need such as intermediate files, etc.

Schematically, we can visualize the path to the project directory as follows:

![](/images/intro_to_yens/project-dir.png)

The absolute path to your project space is:

```bash
/zfs/projects/students/<your-project-dir>
```

where `<your-project-dir>` is the name of your project directory (created for you by the DARC team after the request for a new project space form is filled out). If you are a faculty, your new project will live in `/zfs/projects/faculty` directory.

**Backups**

Files on ZFS are backed up as "snapshots" and can be restored manually by any user. Please see the page <a href="/faqs/howRecoverZFSFiles.html" target="_blank">How Do I Recover ZFS Files</a> for instructions on recovering files. There is currently an off-site disaster recovery solution implemented as well for both ZFS and home directories.

### Local Disk

On each Yen machine, there is a local scratch space mounted at ```/scratch```. All yen users are free to make use of this space. Much like a hard drive on your laptop, this can be accessed only from that single Yen machine. 

{% include warning.html content="Note that scratch space on all yens is cleared during system reboots, and is subject to intermittent purging as needed by the admins. Therefore local scratch space is usually best only for temporary files." %}

If you need to work with the older AFS file system, see <a href="/faqs/afsLink.html" target="_blank">this page</a> to learn about how to access your AFS space on the Yens. 

---
<a href="/gettingStarted/5_yen_software.html"><span class="glyphicon glyphicon-menu-left fa-lg" style="float: left;"/></a> <a href="/gettingStarted/7_transfer_files.html"><span class="glyphicon glyphicon-menu-right fa-lg" style="float: right;"/></a>
