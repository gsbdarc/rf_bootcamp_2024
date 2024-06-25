---
title: 2. Submit Your First Job to Yen-Slurm
layout: page
nav_order: 2
parent: Day 4
updateDate: 2024-06-25
---

# {{ page.title }}


## Running Python Script on the Command Line 
Navigate to the `examples` directory. Just as we ran the R script on the interactive yen nodes, we can run the Python script on the command line.  

Let's run a python version of the script, `investment-npv-serial.py`, which is a serial version of the script that does not use multiprocessing.  View the complete script [here](https://github.com/gsbdarc/rf_bootcamp_2024/blob/main/examples/investment-npv-serial.py).

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

