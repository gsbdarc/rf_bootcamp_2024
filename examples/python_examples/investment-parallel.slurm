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
