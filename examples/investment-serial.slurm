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
