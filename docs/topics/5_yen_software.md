---
title: 5. Yen Software
layout: page 
parent: Topics 
nav_order: 5
updateDate: 2023-12-19
---

# {{ page.title }}
---
There's a number of software packages available for use on the Yen servers.  Here is the current list:

* Anaconda
* bats
* dotnet
* Google Drive
* Go
* GSL
* Gurobi
* HDF5
* Intel-python
* Julia
* KNitro
* Mathematica
* Matlab
* Microsoft-R
* mosek
* OpenMPI
* PostgreSQL
* Python
* PyTorch
* R
* rclone
* RStudio
* SAS
* Singularity
* Stata
* Tensorflow
* Tomlab

## Loading the appropriate software

We use Linux module system to load the software into your current environment. Linux modules are used on research servers
as well as bigger high performance computing clusters like the <a href="https://rcpedia.stanford.edu/yen/scheduler.html" target="_blank">Yen-Slurm</a> at the GSB and <a href="https://www.sherlock.stanford.edu/" target="_blank">Sherlock</a> at Stanford. 
The advantage of the module system is that as a system user you do not need to install the software yourself nor do you need to mess with setting up the paths correctly. 
You simply load it and unload it in your current session and the correct paths get added to your environment variables. For software like
Python, R and Julia, etc the user still needs to install their own libraries or packages. We will go over the details of how
to install packages later in this course. Another advantage of the module system is that several versions of the same sofware
can coexist and if your research uses a specific version of software you can stick with it even though the newer versions of that software exist.

### See available software

Check the current list of available software and versions on the Yen servers with the following command:


```bash
$ module avail
```

You should see the following:
```bash
------------------------------------------------ /software/modules/Core -------------------------------------------------
   R/3.6.3                   gurobi/9.5.2                julia/1.7.3                   python/3.10.11
   R/4.0.2                   gurobi/10.0.0        (D)    julia/1.8.0                   python/3.11.3
   R/4.1.3                   gurobipy/9.5.2              julia/1.9.2            (D)    pytorch/2.0.1         (g)
   R/4.2.1            (D)    gurobipy/10.0.0      (D)    knitro/12.0.0                 rclone/1.47.0
   anaconda/5.2.0            gurobipy3/9.5.2             knitro/12.1.1          (D)    rclone/1.54.0
   anaconda3/5.2.0           gurobipy3/10.0.0     (D)    mathematica/11.2              rclone/1.60.0
   anaconda3/2022.05  (D)    hdf5/1.12.0                 matlab/R2018a                 rclone/1.62.2
   bats/1.5.0                intel/2019.4                matlab/R2018b                 rclone/1.63.1         (D)
   bbcp/17.12.00.00.0        intel-python/2019.4         matlab/R2019b                 rstudio/1.1.463
   dotnet/2.1.500            intel-python3/2019.4        matlab/R2021b                 rstudio/2022.07.2+576 (D)
   dotnet/3.0.0-p2    (D)    julia/0.7.0                 matlab/R2022a                 sas/9.4
   emacs/27.2                julia/1.0.0                 matlab/R2022b          (D)    singularity/3.4.0
   gdrive/2.1.0              julia/1.0.2                 microsoft-r-open/3.5.3        stata/16
   go/1.13                   julia/1.2.0                 mosek/8.1.0.77                stata/17              (D)
   gsl/2.7.1                 julia/1.3.1                 openmpi/4.1.0                 stata/18
   gurobi/8.0.1              julia/1.5.1                 postgresql/15.1        (g)    tensorflow/2          (
g)
   gurobi/9.0.2              julia/1.6.2                 python/3.10.5          (D)    tomlab/8.8

  Where:
   g:  built for GPU
   D:  Default Module

Use "module spider" to find all possible modules.
Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".
```

If you are looking for all available R modules, you can filter `module avail` command as follows:

```bash
$ module avail R/
```

You should see the list of all avaible R versions that are already installed on the Yen server:

```bash
------------------------------------------------ /software/modules/Core -------------------------------------------------
   R/3.6.3    R/4.0.2    R/4.1.3    R/4.2.1 (D)

  Where:
   D:  Default Module

Use "module spider" to find all possible modules.
Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".
```

{% include tip.html content="If you do not see the software or a particular software version that you need for your research,
please email us with the addition request at [gsb_darcresearch@stanford.edu](mailto:gsb_darcresearch@stanford.edu)." %}

If there are multiple versions of the same sofware, the default version is indicated by a `(D)` next to the module name. 
For example, the default R version is currently R/4.2.1 If you are happy with the default version, you can simple type:

```bash
$ module load R
```

and the default version will be loaded. You can also use the shorthand `ml` instead of typing `module load` and `module list`. 
If you want to downgrade to an older R version, you
can specify the version number:

```bash
$ ml R/4.1.3
```

To see currently loaded modules, use:

```bash
$ module list
```

Or with a shorthand:
```bash
$ ml
```

You should see:

```bash
Currently Loaded Modules:
  1) rstudio/2022.07.2+576   2) R/4.1.3
```

We see that together with R software, the RStudio module is also loaded automatically.

If you want to switch R versions, you can use:

```bash
$ ml swap R/4.2.1
```

Then, run:
```bash
$ ml
```

You should see:

```bash
Currently Loaded Modules:
  1) rstudio/2022.07.2+576   2) R/4.2.1 
```

You can unload an individual module with:

```bash
$ module unload rstudio
```

Or with a shorthand:
```bash
$ ml -rstudio
```
Or you can unload all modules that you have currently loaded with:

```bash
$ ml purge
```

Now, if you run 

```bash
$ ml
```

You will see:

```bash
No modules loaded
```

Sometimes you want to know the path where software binary is installed. For example, you might use this information 
to install some R packages from source. To get details about a currently loaded package, use:

```bash
$ ml R/4.2.1
$ ml show R
```

This will print the following information that might be useful:

```bash
--------------------------------------------------------------------------------------------------
   /software/modules/Core/R/4.2.1.lua:
---------------------------------------------------------------------------------------------------
whatis("Name: R")
whatis("Version: 4.2.1")
whatis("Category: tools")
whatis("URL: http://cran.cnr.berkeley.edu/")
whatis("Description: R")
family("R")
load("rstudio")
prepend_path("PATH","/software/free/R/R-4.2.1/bin")
```

Linux modules only modify your current working environment which means that if you lose connection to the Yens or close your terminal window,
you will need to reload the modules. But all of the libraries or packages that you have installed as a user will persist and 
only need to be installed once.

Once the software you want to use is loaded, the binary is available for you to use from the command line. 
For example, if you want to install R packages or run interactive R console, type:

```bash
$ R
```

The interactive R console will open with the R version matching the module you have loaded:

```R
R version 4.2.1 (2022-06-23) -- "Funny-Looking Kid"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.
```

Type `q()` to exit out of R:

```R
> q()
Save workspace image? [y/n/c]: n
```

---
