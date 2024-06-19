---
title: 1. Computationally Intensive Empirical Tasks 
layout: page
nav_order: 1
parent: Day 3 
updateDate: 2024-06-19
---

# {{ page.title }}
---
## Common examples of tasks that may require a computing cluster
- Analyzing a large dataset
- Running many instances of a simulation
- Estimating parameters for a structural model
- Training / fine-tuning large language models

Most times you will need to move to a compute cluster, it will be due to Memory or Runtime.

# Memory Issues
- When not being used, data is stored on the hard drive (also called “storage” or disk). When in use a copy is stored in RAM or "Random Access Memory" or simply “memory”.
- RAM can be accessed and manipulated much faster than even the best SSDs (by 100-1000x).
- Once you run out of RAM processes move onto the hard drive and slow down.
- Check your memory if having issues running a script, move if memory is filled in the process.
- Most modern laptops have 4-16 GB of RAM. If your dataset is over half the size of your RAM, your computer probably won't be too happy.

# Runtime Issues
- Memory is where information is stored, but the CPU does the work.
- CPUs are rated by the processing speed (Hz) and number of instruction centers (cores).
- If instructions need to be performed in order, things can take a very long time:
    - Say we have a function called runSimulation() which takes 1 minute to run on your laptop CPU.
    - Doing so 1000 times on the laptop would take 1000 minutes.
    - We don't have to do them in order though... with 100 laptops this would take 10 minutes.


# Parallelization and Multiple CPUs
- A function which does not change anything outside its local environment has no ‘side effects’.
- Multiple CPUs can work at the same time provided their work has no interacting side effects.
- Parallelization often increases memory costs by duplicating data (tradeoff between runtime and memory optimization).
- Parallelizing processes is a great way to speed them up, but requires time consuming coding.
