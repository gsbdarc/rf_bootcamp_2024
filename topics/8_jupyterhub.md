---
title: 8. JupyterHub on Yen Servers
layout: page 
parent: topics 
nav_order: 8
updateDate: 2023-12-20
---

# {{ page.title }}
---

## Web-based Computing
Web-based computing is available on the interactive Yen servers with <a href="https://jupyterhub.readthedocs.io/en/stable/" target="_blank">JupyterHub</a> without the need to `ssh` from the terminal.  JupyterHub is a platform designed to allow multiple users to launch their own JupyterLab instances on a shared system with minimal user effort. 
It also gives you a terminal, file browser and a way to run Jupyter notebooks with several language kernels including Python 3, R, Julia, MATLAB, SAS, and Stata. 

## Getting Started

To get started, open a web browser and visit one of the following links for each server:

- <a href="https://yen1.stanford.edu/jupyter/" target="_blank">Yen1 https://yen1.stanford.edu/jupyter</a>
- <a href="https://yen2.stanford.edu/jupyter/" target="_blank">Yen2 https://yen2.stanford.edu/jupyter</a>
- <a href="https://yen3.stanford.edu/jupyter/" target="_blank">Yen3 https://yen3.stanford.edu/jupyter</a>
- <a href="https://yen4.stanford.edu/jupyter/" target="_blank">Yen4 https://yen4.stanford.edu/jupyter</a>
- <a href="https://yen5.stanford.edu/jupyter/" target="_blank">Yen5 https://yen5.stanford.edu/jupyter</a>

You will need to login with your SUNet credentials, and then click on `Start My Server`.  From there, you will have access to the web-based computing services available.

![](/intro_to_yens/assets/images/launch-hub.png)

{% include important.html content="JupyterHub instances on each `yen` server are independent of each other! If you launch a server on `yen3`, it will only use resources available on `yen3`." %}

{% include warning.html content="JupyterHub does not work well on Safari - we recommend using a different browser." %}

## Features of JupyterHub

We recommend taking a look at the <a href="https://jupyter-notebook.readthedocs.io" target="_blank">official documentation</a> for JupyterHub if you have any questions on the features below!

The JupyterLab interface looks like:

![](/intro_to_yens/assets/images//jupyterlab.png)

The front panel has a Launcher interface from which you can start notebooks with different language kernels and custom environment kernels.

### Notebook
![](/intro_to_yens/assets/images/notebooks.png)

Notebooks allow you to write code and execute it on the yens in your web browser. 
Code is written into cells, which can be run in any order, on demand. 
You can also include text, images, and plots to make your code read like a lab notebook.  
Contact the [DARC team](mailto:gsb_darcresearch@stanford.edu) if you have a language you would like installed.

**Note:** If you do not see Julia as an option under Notebooks, see <a href="https://rcpedia.stanford.edu/faqs/installJuliaOnJupyter.html" target="_blank">this page</a> on how to add it.

### RStudio
-----------
![](/intro_to_yens/assets/images/rstudio.png)

RStudio GUI is also available! Clicking this link will bring up a new tab with a web-based RStudio on the Yens.

If you opened up a notebook and want to get back to the Launcher interface to launch other software as well, click the "+" button in the upper left corner:
![](/intro_to_yens/assets/images/launcher.png)


### Console
-------------------------
![](/intro_to_yens/assets/images/console.png)

You can launch interactive consoles from JupyterHub.  These will behave very similar to the versions on the Yen servers.

### Terminal
-------------------------
![](/intro_to_yens/assets/images/terminal.png)

You can launch a terminal from JupyterHub.  This provides access to commands you would normally run on the command line on the Yens, 
but through the web browser. However, we have seen issues with JupyterHub terminal (as well as VSCode) that modifies or overwrites python paths and environment variables so for package installations, we recommend using a terminal outside of JupyterHub.

Let's open up a Terminal and make a new directory where the scripts for this class will live.


```bash
$ mkdir intro_yens_sep_2023
$ mv investment-npv-parallel.R intro_yens_sep_2023
```
We moved the script `investment-npv-parallel.R` into the newly created directory, `intro_yens_sep_2023`.

### File Browser
The JupyterHub instances will automatically launch from your home directory on the Yens. 
Your home directory is a file icon shown by the red arrow:

![](/intro_to_yens/assets/images/file-browser.png)

The current directory is also displayed:

![](/intro_to_yens/assets/images/file-browser-current.png)

Clicking on the home icon (folder icon), returns the file browser back to your home where you can access any directories that are accessible from your home on the Yens.

![](/intro_to_yens/assets/images/home-dir-zfs.png)

Double click on the `zfs` directory in your home directory to navigate to your ZFS project files.


### File Upload and Download
----------------------------
![](/intro_to_yens/assets/images/jupyter_upload.png)

One very useful feature of JupyterHub is the ability to upload and download files from ZFS. 
First, make sure you are in the proper directory.  Then, to upload, click the up arrow on the top left of your screen to select a file from your local machine ot upload to the Yens.

![](/intro_to_yens/assets/images/jupyter_download.png "File Download")

To download, right click the file you would like to download to your local machine, and click "Download".


### Installing Packages
-----------------------
JupyterHub loads packages found in your `~/.local/` directory. 
If you wish to install Python packages to be available in a JupyterHub notebook, we recommend using <a href="https://rcpedia.stanford.edu/training/5_python_env.html" target="_blank">Python `venv`</a> environment. 

The following limits will be imposed on JupyterHub servers:

<div class="row">
    <div class="col-lg-12">
      <H2> </H2>
    </div>
  </div>
  <div class="row">
    <div class="col-lg-12">
     <div class="fontAwesomeStyle"><i class="fas fa-tachometer-alt"></i> Compute Limits</div>
<iframe class="airtable-embed" src="https://airtable.com/embed/shrGC2dYzvDSgJfXa?backgroundColor=purple" frameborder="0" onmousewheel="" width="100%" height="533" style="background: transparent; border: 1px solid #ccc;"></iframe>
   </div>
    <div class="col col-md-2"></div>
  </div>

JupyterHub instance will shut down after 3 hours idle (no notebooks actively running code).

{% include warning.html content="Idle servers shut down will not retain any local packages or variables in the notebooks.  Please save your output." %}

If your processes require more than these limits, reach out to the <a href="https://rcpedia.stanford.edu/services/researchSupportRequest.html" target="_blank">DARC team</a> for support.

### Text File Editor
-------------------------
![](/intro_to_yens/assets/images/editor.png)

Finally, you can also edit text files like R scripts directly on JupyterHub. Clicking on Text File icon will open a new file that you can edit. Similarly, clicking on Python File will create an empty `.py` file and clicking on R File will create an empty `.r` file.
You can also navigate to a directory that has the scripts you want to edit and double click on the script name to open it up in the Text Editor.

For example, navigate to `intro_yens_sep_2023` folder in file brower first then double click on `investment-npv-parallel.R` file to open it in the text editor:
![](/intro_to_yens/assets/images/edit-r-script.png)

---
