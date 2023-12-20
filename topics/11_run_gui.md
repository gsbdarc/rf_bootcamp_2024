---
title: 11. Running Software with a GUI 
layout: page 
parent: Topics 
nav_order: 11
updateDate: 2023-12-19
---

# {{ page.title }}
---

### Running R Software with a Graphical Interface
An X server is used to manage graphical display and GUI's. Make sure you have X server installed on your local computer first:

- For **Mac OS**, you need to 
have <a href="https://www.xquartz.org/" target="_blank">XQuartz</a> installed first. XQuartz usually requires restarting your computer before you can use it.

- For **Windows**, you need to have <a href="https://mobaxterm.mobatek.net/" target="_blank">MobaXterm</a> installed first. 

To run a Graphical User Interface (GUI) such as RStudio, MATLAB IDE, and SAS, we need to logout (type `exit` or `logout`) and log back in to the Yens with X forwarding.
Once you logged out of the Yens, login with:

```bash
$ ssh -Y <SUNetID>@yen.stanford.edu
```

When prompted, type your SUNet ID password. Then, complete the two-factor authentication process.
After you successfully login, check that X-forwarding works correctly. Choose any of the following commands and type it in 
the yen command line interface as all of them will pop up a window if everything is working correctly - `xeyes`, `xcalc`, `xlogo` or `xclock` 
(or choose your favorite X11 command line program).


```bash
$ xeyes
```
which will pop up a window with eyes tracking where your mouse is.

![](/images/intro_to_yens/xeyes.png)


#### R / RStudio GUI

To run RStudio GUI, load the R module with the version of R that you want:

```bash
$ ml R
```

List the loaded modules:

```bash
$ ml 
```

```bash
Currently Loaded Modules:
  1) rstudio/2022.07.2+576   2) R/4.2.1
```

We see that RStudio is loaded automatically when you load R module. We can now launch RStudio with:

```bash
$ rstudio
```

The RStudio GUI will pop open and you can do anything you would normally do in RStudio (but with noticeable delay due to X tunneling):

![](/images/intro_to_yens/rstudio-gui.png)


If you forget to load R module or loaded only the rstudio module, you will see an error that R is not found:

![](/images/intro_to_yens/rstudio-err.png)

If that happens, just load R module and start RStudio again.

---
<a href="/gettingStarted/10_screen.html"><span class="glyphicon glyphicon-menu-left fa-lg" style="float: left;"/></a> <a href="/gettingStarted/12_monitor_usage.html"><span class="glyphicon glyphicon-menu-right fa-lg" style="float: right;"/></a>
