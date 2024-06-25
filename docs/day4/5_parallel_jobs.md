---
title: 5. Parallel Script
layout: page
nav_order: 5
parent: Day 4
updateDate: 2024-06-20
---

# {{ page.title }}

## Multiprocessing Script
We can modify our `investment-npv-serial.py` script to use `multiprocessing` python package.

{% include warning.html content="Because this Python code uses multiprocessing and the yens are a shared computing environment, we need to be careful about how Python sees and utilizes the shared cores on the yens."%}

Again, we will hard code the number of cores for
the script to use in this line in the python script:

```python
ncore = 12
````

Consider a slightly modified program, `investment-npv-parallel.py`:

```python
import time
import numpy as np
import pandas as pd
import multiprocessing as mp
import matplotlib.pyplot as plt

np.errstate(over='ignore')

# set the number of cores here
ncore = 12

# define a function for NPV calculation
def npv_calculation(cashflows, discount_rate):
    # Calculate NPV using the formula
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

# create a multiprocessing pool to run trials in parallel
pool = mp.Pool(processes = ncore)

# perform the Monte Carlo simulation in parallel
results = pd.DataFrame( pool.map(simulate_trial, range(num_trials)), columns = ['NPV'] )

# close the pool and wait for all processes to finish
pool.close()
pool.join()

end_time = time.time()
elapsed_time = end_time - start_time

print(f"Elapsed time: {elapsed_time:.2f} seconds")

print("Parallel NPV Calculation (using", ncore, "cores):")
# print summary statistics for NPV
print(results.describe())

# plot a histogram of the results
plt.hist(results, bins=50, density=True, alpha=0.6, color='g')
plt.title('NPV distribution')
plt.xlabel('NPV Value')
plt.ylabel('Frequency')
plt.savefig('histogram.png')
```

We'll then make our submit script - noting that we will request `cpus-per-task=12` (you can also use a shorthand `-c 12`) to request 12 cores to run in parallel.

Let's save it as `investment-parallel.slurm` and change it to include your email address:

```bash
#!/bin/bash

# Example of running parallel python script in a batch mode

#SBATCH -J npv-par
#SBATCH -p normal
#SBATCH -c 12                            # CPU cores (up to 256 on normal partition)
#SBATCH -t 1:00:00
#SBATCH -o npv-par-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@stanford.edu

# Run python script
python3 investment-npv-parallel.py
```

To submit this script, we run:

```bash
$ sbatch investment-parallel.slurm
```

Monitor the queue:

```bash
$ squeue
```

After the job has finished, look at the emails and output file.

