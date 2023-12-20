---
title: 4. Logging In
layout: page 
parent: topics 
nav_order: 4
updateDate: 2023-12-19
---
# {{ page.title }}
---

{% include important.html content="You should have a SUNet ID as a prerequisite to use the Yen server and know your password." %}

Yen access is provided in the following two ways:

1. Automatically granted to GSB faculty, postdocs, PhD Students, and Research Fellows
2. <a href="https://rcpedia.stanford.edu/yen/Collaborators.html" target="_blank">Collaborator access</a> sponsored by a GSB faculty member 

If you belong to one of the above two groups, you can use the Yen servers! Below are the instructions for connecting to the Yen servers.

We can use a Secure Shell (SSH) protocol to securely connect from your local laptop to another computer such as a remote Yen server. 
Below are the instructions for connecting from a Mac / Linux OS laptop and a Windows laptop. 
 

# Login 
-----------------------------------
Open a terminal or a Moba terminal. Enter the SSH command to login into the server as shown below (Note: replace SUNetID with **your SUNet ID** and do not type the brackets!). You will 
be asked to enter your password and authenticate with Duo. You will **not** see your password being typed. 

```bash
$ ssh <SUNetID>@yen.stanford.edu
```

For example, I login with:
```bash
$ ssh nrapstin@yen.stanford.edu
```

If the login is successful, you will see something similar to the following:

![](/intro-to-yens/assets/images/ssh_yens.png)

You can also log into a specific interactive yen server. Choose what yen server you would like to connect to (yen1, yen2, yen3, yen4 or yen5).
Here is the example of how to login to the yen3 server: 


```bash
$ ssh <SUNetID>@yen3.stanford.edu
```

{% include tip.html content="If you do not want to type `ssh yen.stanford.edu` every time you want to login..."%}

Save an alias in your `~/.bash_profile` with a shorhand for the yen servers. For example, my `~/.bash_profile` has this line 
 `alias yen="ssh yen.stanford.edu"`. Then instead of typing `ssh yen.stanford.edu`, I simply type `yen` from the Terminal
 when I want to connect to the Yen servers.

{% include tip.html content="If your user name on your computer is the same as your SUNet ID, you can simply type `ssh yen.stanford.edu`."%}

## With a graphical interface

If your work requires a Graphical User Interface (GUI) such as MATLAB IDE or RStudio or you need to pop up separate windows of
any kind, you will need to login to the Yen servers with the X forwarding enabled. 

**For Mac OS**, you need to 
have <a href="https://www.xquartz.org/" target="_blank">XQuartz</a> installed first. XQuartz usually requires restarting your computer before you can use it.

**For Windows**, you need to have <a href="https://mobaxterm.mobatek.net/" target="_blank">MobaXterm</a> installed first. 

The steps to login with a graphical interface are the same as the above except that you need to add a Y-flag in the SSH command.
Again, in the Terminal window, type:

```bash
$ ssh -Y <SUNetID>@yen.stanford.edu
```

When prompted, type your SUNet ID password. Then, complete the two-factor authentication process.
After you successfully login, check that X-forwarding works correctly. Choose any of the following commands and type it in 
the yen command line interface as all of them will pop up a window if everything is working correctly - `xeyes`, `xcalc`, `xlogo` or `xclock` 
(or choose your favorite X11 command line program).

---
