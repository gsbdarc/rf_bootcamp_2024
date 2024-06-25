---
title: 7. Running R Scripts Interactively 
layout: page
nav_order: 7
parent: Day 3
updateDate: 2024-06-20
---

# {{ page.title }}
---

## Managing R Software Libraries and Versions
The R software is installed system-wide, allowing each user to maintain their own set of R packages within their home directory by default. Furthermore, each R version has its dedicated library, distinct from other versions.  
Every R version will also have its own library separate from other versions. For example, R 4.0 will have its user-installed 
packages side by side with R 4.2 library containing the user-installed packages specific to that version. 

When upgrading your
R version (e.g., to run code with a newly released R version), you must first install packages that are needed for your script to run for that specific R version. However, once the package is
installed, you can load it in your scripts without the need for repeated installations upon each login.

Moreover, if you require access to a newer software version that is not currently available on the system, please don't hesitate to [contact DARC](mailto:gsb_darcresearch@stanford.edu) to request its installation. 

### Installing R packages without a Graphical Interface

Load the R module with the version that you want (R 4.2 is the current default).

For example, let's use the newest R version available on the yens:

```bash
$ ml R
```

Start interactive R console by typing `R`.

You should see:

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

>
```

Let's install two multiprocessing packages on the yens that we will use for the R example. 

```R
> install.packages('foreach')
```
If this is your first time installing R package for this R version on the Yens, you will be asked to create a personal library
(because users do not have write permissions to the system R library). Answer `yes` to both questions:

```R
Warning in install.packages("foreach") :
  'lib = "/software/free/R/R-4.2.1/lib/R/library"' is not writable
Would you like to use a personal library instead? (yes/No/cancel) yes

Would you like to create a personal library
‘~/R/x86_64-pc-linux-gnu-library/4.2’
to install packages into? (yes/No/cancel) yes
```
This creates a new personal R 4.2 library in your home directory. The library path is 
`~/R/x86_64-pc-linux-gnu-library/4.2` where all of the user packages will be installed. Once the library is created, next 
package will be installed there automatically.

Pick any mirror in the US. 

```R
Installing package into ‘/home/users/nrapstin/R/x86_64-pc-linux-gnu-library/4.2’
(as ‘lib’ is unspecified)
--- Please select a CRAN mirror for use in this session ---
Secure CRAN mirrors

 1: 0-Cloud [https]
 2: Australia (Canberra) [https]
...
74: USA (IA) [https]
75: USA (MI) [https]
76: USA (OH) [https]
77: USA (OR) [https]
78: USA (TN) [https]
79: USA (TX 1) [https]
80: Uruguay [https]
81: (other mirrors)

Selection: 77
```

If the package is successfully installed, you should see:

```R
* DONE (foreach)

The downloaded source packages are in
	‘/tmp/RtmpsYpzoP/downloaded_packages’
```

Then install `doParallel` package: 

```R
> install.packages("doParallel")
```

When the package is done installing, you will see:

```R
* DONE (doParallel)

The downloaded source packages are in
	‘/tmp/Rtmpwy8WeV/downloaded_packages’
```
-------------------------
### Running R Script Interactively

Now that we have loaded R module and installed R packages that we are going to use, we are ready to run our code. 
You can run R code line by line interactively by copying-and-pasting into the R console. 
For example,

```R
> print('Hello!')
[1] "Hello!"
```

The advantage of interactive console is that the results are printed to the screen immediately and if you are developing code
or debugging, it can be very powerful. But the disadvantage is that if you close the terminal window or lose connection,
the session is not saved and you will need to reload the R module and paste all of the commands again. 
So, use this method for when you need interactive development / debugging environment. Another disadvantage is that if you 
did not login with the graphical interface (X forwarding) you will not be able to plot anything in the interactive console.
So, if you need plots and graphs, either use `-Y` flag when connecting to the Yens or use RStudio on JupyterHub. 

We can then quit out of R without saving workspace image:

```R
> q()
Save workspace image? [y/n/c]: n
```
-------------------------
Throughout this course, we will explore practical examples that showcase the power of data analytics and research computing.
One such example involves Monte Carlo simulations to calculate Net Present Value (NPV) – a fundamental concept in economics and finance.

## Introducing an R Example
In the realm of economics research, assessing the value of future cash flows is crucial. The Net Present Value (NPV) calculation helps us evaluate the worth of an investment or project by discounting future cash flows to their present value.

Monte Carlo simulations are a powerful computational approach used to model complex systems and make informed decisions in the face of uncertainty. In our NPV calculation example, we will employ Monte Carlo simulations to explore various scenarios and evaluate the NPV of investment projects.

Our Monte Carlo NPV simulation involves the following steps:

1. Randomly generate cash flows over a specified number of periods.
2. Assign a random discount rate to each trial, representing different scenarios.
3. Calculate the NPV for each trial using the generated cash flows and discount rate.
4. Repeat this process for a substantial number of trials (e.g., 50,000) to obtain a distribution of NPV values.
5. Analyze the results to understand the range and characteristics of NPV outcomes.

By running this simulation, we will gain valuable insights into how different input parameters impact NPV calculations and enable more informed economic decision-making. We will run this hands-on example in serial and in parallel, interactively and using a scheduler. We are going to run the R code, `investment-npv-parallel.R`. View the complete script [here](https://github.com/gsbdarc/rf_bootcamp_2024/blob/main/examples/investment-npv-parallel.R).

#### Running Serial R Script on the Command Line
If you want to simply run the script, you can do so from the command line. 

{% include warning.html content="Because this R code uses multiprocessing and the yens are a shared computing environment, we need to be careful about how R sees and utilizes the shared cores on the yens."%}


We never use `detectCores()` function on the shared systems, so instead, we will hard code the number of cores for
the script to use in this line in the R script:

```R
ncore <- 1 
```

After loading the R module, we can run this script with `Rscript` command on the command line:

```bash
$ Rscript investment-npv-parallel.R 
```

```bash
Loading required package: iterators
Loading required package: parallel
   user  system elapsed
274.631   0.433 275.130
Parallel NPV Calculation (using 1 cores):
       V1
 Min.   :-727.7947
 1st Qu.: -96.5315
 Median :  -0.0326
 Mean   :  -0.0505
 3rd Qu.:  96.3001
 Max.   : 700.4002
```
Again, running this script is active as long as the session is active (terminal stays open and you do not lose connection).
