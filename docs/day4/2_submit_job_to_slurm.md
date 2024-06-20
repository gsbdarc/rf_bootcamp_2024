---
title: 2. Submit Your First Job to Run on Yen-Slurm
layout: page
nav_order: 2
parent: Day 4
updateDate: 2024-06-20
---

# {{ page.title }}

We are going to copy scripts including example python scripts and Slurm submission scripts.
Make a directory inside your home directory called `intermediate_yens_2023`.
Then copy the scripts for this class from `scratch` to your `intermediate_yens_2023` working directory so you can modify and run them.

```bash
$ cd
$ mkdir intermediate_yens_2023
$ cd intermediate_yens_2023
$ cp /scratch/darc/intermediate-yens/* .
```

### Running Python Script on the Command Line 
Just as we ran <a href="/gettingStarted/9_run_jobs.html" target="_blank">R script</a> on the interactive yen nodes, we can simply run a Python script on the command line.  

Let's run a python version of the script, `investment-npv-serial.py`, which is a serial version of the script that does not use multiprocessing.

```python
# In the context of economics and finance, Net Present Value (NPV) is used to assess
# the profitability of investment projects or business decisions.
# This code performs a Monte Carlo simulation of Net Present Value (NPV) with 500,000 trials in serial,
# utilizing multiple CPU cores. It randomizes input parameters for each trial, calculates the NPV,
# and stores the results for analysis.
import time
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

np.errstate(over='ignore')

# define a function for NPV calculation
def npv_calculation(cashflows, discount_rate):
    # calculate NPV using the formula
    npv = np.sum(cashflows / (1 + discount_rate) ** np.arange(len(cashflows)))
    return npv

# function for simulating a single trial
def simulate_trial(trial_num):
    # randomly generate input values for each trial
    cashflows = np.random.uniform(-100, 100, 10000)  # Random cash flow vector over 10,000 time periods
    discount_rate = np.random.uniform(0.05, 0.15)  # Random discount rate

    # ignore overflow warnings temporarily
    with np.errstate(over = 'ignore'):
        # calculate NPV for the trial
        npv = npv_calculation(cashflows, discount_rate)

    return npv

# number of trials
num_trials = 500000

start_time = time.time()

# Perform the Monte Carlo simulation in serial
results = np.empty(num_trials)

for i in range(num_trials):
    results[i] = simulate_trial(i)

results = pd.DataFrame( results, columns = ['NPV'])

end_time = time.time()
elapsed_time = end_time - start_time

print(f"Elapsed time: {elapsed_time:.2f} seconds")

print("Serial NPV Calculation:")
# Print summary statistics for NPV
print(results.describe())

# Plot a histogram of the results
plt.hist(results, bins=50, density=True, alpha=0.6, color='g')
plt.title('NPV distribution')
plt.xlabel('NPV Value')
plt.ylabel('Frequency')
plt.savefig('histogram.png')
```

We can call the function like this:
```bash
$ python3 investment-npv-serial.py
```

The output should look like:
```bash
Elapsed time: 185.77 seconds
Serial NPV Calculation:
                 NPV
count  500000.000000
mean       -0.119349
std       144.435560
min      -723.741078
25%       -96.553456
50%         0.105534
75%        96.588246
max       721.687146
```

## Submit Serial Script to the Scheduler

We'll prepare a submit script called `investment-serial.slurm` and submit it to the scheduler. Edit the slurm script to include
your email address.

```bash
#!/bin/bash

# Example of running python script in a batch mode

#SBATCH -J npv-serial
#SBATCH -p normal,dev
#SBATCH -c 1                            # CPU cores (up to 256 on normal partition)
#SBATCH -t 1:00:00
#SBATCH -o npv-serial-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@stanford.edu

# Run python script
python3 investment-npv-serial.py
```

Then submit the script:

```bash
$ sbatch investment-serial.slurm
```

You should see a similar output:

```bash
Submitted batch job 44097
```

Monitor your job:
```bash
$ squeue
```

The script should take less than 5 minutes to complete. Look at the slurm emails after the job is finished.
Look at the output file.

## Using `venv` Environment in Slurm Scripts
We can also use a `venv` environment python instead of a system `python3` when running scripts via Slurm.

We can modify the slurm script to use previously created `venv` environment as follows:

```bash
#!/bin/bash

# Example of running python script in a batch mode

#SBATCH -J npv-serial
#SBATCH -p normal,dev
#SBATCH -c 1                            # CPU cores (up to 256 on normal partition)
#SBATCH -t 1:00:00
#SBATCH -o npv-serial-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@stanford.edu

# Activate venv 
source /zfs/gsb/intermediate-yens/venv/bin/activate

# Run python script
python investment-npv-serial.py
``` 

In the above slurm script, we first activate `venv` environment and execute the python script using `python` in the active environment.

