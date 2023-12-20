---
title: 2. Running R Script Locally 
layout: page
parent: Topics 
nav_order: 2
updateDate: 2023-12-19
---
# {{ page.title }}
---

Throughout this course, we will explore practical examples that showcase the power of data analytics and research computing.
One such example involves Monte Carlo simulations to calculate Net Present Value (NPV) – a fundamental concept in economics and finance.

## Introducing an R Example
In the realm of economics research, assessing the value of future cash flows is crucial. The Net Present Value (NPV) calculation helps us evaluate the worth of an investment or project by discounting future cash flows to their present value. 

Monte Carlo simulations are a powerful computational approach used to model complex systems and make informed decisions in the face of uncertainty. In our NPV calculation example, we will employ Monte Carlo simulations to explore various scenarios and evaluate the NPV of investment projects.

Our Monte Carlo NPV simulation involves the following steps:

1. Randomly generate cash flows over a specified number of periods.
2. Assign a random discount rate to each trial, representing different scenarios.
3. Calculate the NPV for each trial using the generated cash flows and discount rate.
4. Repeat this process for a substantial number of trials (e.g., 500,000) to obtain a distribution of NPV values.
5. Analyze the results to understand the range and characteristics of NPV outcomes.

By running this simulation, we will gain valuable insights into how different input parameters impact NPV calculations and enable more informed economic decision-making. We will run this hands-on example first on our local machine, then on the yens, in serial and in parallel. 
If you followed the <a href="/intro-to-yens/prerequisites/setup" target="_blank">Setup Guide</a>, you should have this
script in `intro-to-yens` folder on your Desktop. 

If you don't have the script downloaded already, you can save the following code to a script on your local machine called `investment-npv-parallel.R`.

```R
# In the context of economics and finance, Net Present Value (NPV) is used to
# assess the profitability of investment projects or business decisions. This
# code performs a Monte Carlo simulation of Net Present Value (NPV) with 500,000
# trials in parallel, utilizing multiple CPU cores. It randomizes input
# parameters for each trial, calculates the NPV, and stores the results for
# analysis.

# load necessary libraries
library(foreach)
library(doParallel)

options(warn=-1)

# set the number of cores here
ncore <- detectCores()

# register parallel backend to limit threads to the value specified in ncore
# variable
registerDoParallel(ncore)

# define function for NPV calculation
npv_calculation <- function(cashflows, discount_rate) {
  # inputs: cashflows (a vector of cash flows over time)
  #         and discount_rate (the discount rate).
  npv <- sum(cashflows / (1 + discount_rate)^(0:length(cashflows)))
  return(npv)
}

# number of trials
num_trials <- 500000

cat("Parallel NPV Calculation (", 
    num_trials, "trials using", ncore, "cores ):\n")

# measure the execution time of the Monte Carlo simulation
stout = system.time({
  # use the foreach package to loop through the specified number of trials
  # (num_trials) in parallel within each parallel task, random values for input
  # parameters (cash flows and discount rate) are generated for each trial these
  # random input values represent different possible scenarios
  results <- foreach(i = 1:num_trials, .combine = rbind) %dopar% {
    # randomly generate input values for each trial
    cashflows <- runif(10000, min = -100, max = 100)  # random cash flow vector
    # these cash flows can represent costs (e.g., initial investment) and
    # benefits (e.g., revenue or savings) associated with the project
    discount_rate <- runif(1, min = 0.05, max = 0.15)  # random discount rate
    
    # calculate NPV for the trial
    npv <- npv_calculation(cashflows, discount_rate)
    
  }
})

# print execution time
print(stout)

# print summary statistics for NPV and plot a histogram of the results positive
# NPV indicates that the project is expected to generate a profit (the benefits
# outweigh the costs), making it an economically sound decision. If the NPV is
# negative, it suggests that the project may not be financially viable.
summary(results)
hist(results, main = 'NPV distribution')
```

{% include tip.html content="Because we are running on our local machine it is fine to use the R function `detectCores()`. When we transfer this script to the yens, it is a **very bad** idea to use that funciton. We will instead specify how many cores to use either in the R script or from the command line as a user-specified argument."%}



## Running R Script Locally in RStudio

We need to have installed:

- <a href="https://www.r-project.org/" target="_blank">R</a>
- <a href="https://www.rstudio.com/products/rstudio/download/" target="_blank">RStudio</a>

before we can install R libraries `foreach` and `doParallel`.

Open RStudio and install the two packages from the console panel with the
`install.packages(c("foreach", "doParallel"))` command:

![](/intro-to-yens/assets/images/rstudio_package_install.png)

Once the packages are installed, open the script, `investment-npv-parallel.R` in RStudio and run it. 

![](/intro-to-yens/assets/images/rstudio-run.png)



## Running R Script Locally On the Command Line 

To install R packages without using RStudio, open a terminal or a <a href="https://mobaxterm.mobatek.net/" target="_blank">MobaXterm</a> terminal.


#### Mac OS X

Open the Terminal application (it's in the Utilities folder of the Applications folder). 

![mac terminal](/intro-to-yens/assets/images/terminal-app.png)

#### Windows

Windows does not come with a Terminal application but there are plenty of free and paid terminal emulation software. 
One option is <a href="https://mobaxterm.mobatek.net/" target="_blank">MobaXterm</a> but feel free to explore and 
find the terminal app that works best for you. Once installed, open a terminal. 

Once you have a terminal open and have R installed, launch the R interactive console by typing `R`. 

You should see the following:

```R

R version 4.3.1 (2023-06-16) -- "Beagle Scouts"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin20 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

>
```

Next, you can install the R packages:

```R
> install.packages(c('foreach', 'doParallel'))
```

Select a CRAN mirror when asked (anywhere in the US is fine) and let the installation complete.

You can always check that the packages load without errors:

```R
> library(foreach)
> library(doParallel)
Loading required package: iterators
Loading required package: parallel
```

Also, check where on your local machine the R library is:
```R
> .libPaths()
[1] "/Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/library" 
```

Installing packages from the command line is similar to how we will install packages on the yens. Once both packages are installed successfully, let's run the R code on the command line.



Quit R to get back to the terminal:

```R
> q()
Save workspace image? [y/n/c]: n
```



Run R code:

```bash
$ cd ~/Desktop/intro-to-yens
$ Rscript investment-npv-parallel.R
```

You should see the output printed to the terminal:

```bash
Loading required package: iterators
Loading required package: parallel
   user  system elapsed
734.761  28.238 192.772
Parallel NPV Calculation (using 12 cores):
       V1
 Min.   :-702.5946
 1st Qu.: -96.1572
 Median :   0.1487
 Mean   :   0.1551
 3rd Qu.:  96.4849
 Max.   : 752.0547
```


If you do not see a plot pop up from the `hist()` call while the script is running, the plot is saved as a pdf file 
(`Rplots.pdf`) in the same folder where the R script is located. Find it and open it to see the histogram plot. 


---
