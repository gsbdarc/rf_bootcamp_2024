---
title: 4. Command Line Arguments 
layout: page
nav_order: 4
parent: Day 4
updateDate: 2024-06-20
---

# {{ page.title }}

## Multiprocessing Script with Arguments
We can modify the parallel script to accept the number of cores as a command line argument.

We will use the value of cpus-per-task that we request from Slurm to pass it as an argument to the python script and use that value as the number of cores in paralell. That way we only need to set the cpus-per-task in `#SBATCH` line and use the value stored in the Slurm environment variable.

The modified python script, `investment-npv-parallel-args.py` looks like:

```python
import time, sys
import numpy as np
import pandas as pd
import multiprocessing as mp
import matplotlib.pyplot as plt

np.errstate(over='ignore')

# accept command line arguments
# set the number of cores here from the command line. Avoid using mp.cpu_count() function on the yens.
ncore = int(sys.argv[1])

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

    # Ignore overflow warnings temporarily
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

# Plot a histogram of the results
plt.hist(results, bins=50, density=True, alpha=0.6, color='g')
plt.title('NPV distribution')
plt.xlabel('NPV Value')
plt.ylabel('Frequency')
plt.savefig('histogram.png')
```

Look at the slurm file called `investment-parallel-args.slurm` and edit to include your email address:

```bash
#!/bin/bash

# Example of running parallel python script in a batch mode

#SBATCH -J npv-par-args
#SBATCH -p normal
#SBATCH -c 12                            # CPU cores (up to 256 on normal partition)
#SBATCH -t 1:00:00
#SBATCH -o npv-par-args-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@stanford.edu

# Run python script with the number of cores as a command line arg
python3 investment-npv-parallel-args.py ${SLURM_CPUS_PER_TASK}
```

Submit and monitor:
```bash
$ sbatch investment-parallel-args.slurm
```

---
