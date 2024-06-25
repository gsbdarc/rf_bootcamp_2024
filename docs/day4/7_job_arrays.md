---
title: 7. Job Arrays
layout: page
nav_order: 7
parent: Day 4
updateDate: 2024-06-20
---

# {{ page.title }}

One of Slurm's notable features is its ability to manage job arrays.

A Slurm job array is a convenient and efficient way to submit and manage a group of related jobs as a single entity. Instead of submitting each job individually, you can use <a href="https://slurm.schedmd.com/job_array.html" target="_blank">job arrays</a> to submit multiple similar tasks with a single command, making it easier to handle large-scale computations and parallel processing.

In this guide, we will explore the concept of Slurm job arrays and  demonstrate how to leverage this feature for batch job processing, simplifying the management of repetitive tasks and improving overall productivity on the Yen environment.

Let's take a look at a python script that will be run as an array of tasks, `investment-npv-job-task.py`.

```python
import sys, time
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

np.errstate(over='ignore')

# pick up cashflows and discount rate from command line
args = sys.argv[1] # this will be a long string that we need to convert into a cashflows vector of floats and discount rate as a float
args_list = args.split(',')

# Convert the list of strings to a list of floats
cashflows = [float(x) for x in args_list[:-1]]
discount_rate = float(args_list[-1])

# define a function for NPV calculation
def npv_calculation(cashflows, discount_rate):
    # ignore overflow warnings temporarily
    with np.errstate(over = 'ignore'):
        # calculate NPV using the formula
        npv = np.sum(cashflows / (1 + discount_rate) ** np.arange(len(cashflows)))
        return npv

results = npv_calculation(cashflows, discount_rate)
print(results)
```

The script expects two command line arguments - cashflows and a discount rate and outputs NPV value for those inputs. Alternatively to using `multiprocessing` and `map()` function in `investment-npv-parallel.py` script, we can compute NPV values over different inputs. Thus, a job array is a common scheme for parameter sweep tasks. Each job array task will run the same script but with different inputs. 

To prepare inputs, we first run `write_job_array_inputs.py` script to write 100 lines of cashflows and discount rates that will be passed as inputs. Each line corresponds to inputs for one job array task. 

```bash
$ python3 write_job_array_inputs.py
```

You should see the following output:
```bash
100 lines of data have been written to inputs_to_job_array.csv.
```

Next, we'll prepare a submission script called `investment-job-array.slurm`.

```bash
#!/bin/bash

# Example of running python script as a job array

#SBATCH -J inv-array
#SBATCH --array=1-100
#SBATCH -p normal
#SBATCH -c 1                            # CPU cores per task (up to 256 on normal partition)
#SBATCH -t 1:00:00
#SBATCH -o inv-array-%a.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your_email@stanford.edu

# Read in a specified line number from input file
# line number corresponds to job array task ID
export NUM=$SLURM_ARRAY_TASK_ID
export INPUTS=$(sed "${NUM}q;d" inputs_to_job_array.csv)

# Run every job array task in parallel
python3 investment-npv-job-task.py $INPUTS
```

This script extracts the line number that corresponds to the value of `$SLURM_ARRAY_TASK_ID` environment variable -- in this case, 1 through 100. When we submit this one slurm script to the scheduler, it will become 100 jobs running all at once with each task executing the `investment-npv-job-task.py` script with only those inputs that correspond to one line of inputs from the input file. 


To submit the script, run:

```bash
$ sbatch investment-job-array.slurm
```

You should then see 100 jobs in the queue. 

Each job task produces an out file with a computed NPV value.


## Job Dependency
We can impose job dependency to combine all of the NPV results into one CSV file after all of the tasks have finished.
After you submit the `investment-job-array.slurm` script, you will know the job array ID so you can then run:

```bash
$ srun --dependency=afterok:<array_job_id> ./combine_array_results.sh
```

Replace `<array_job_id>` with your job array ID. This command will ensure that all job array tasks have finished with OK status and then run the shell script to combine the results. 
