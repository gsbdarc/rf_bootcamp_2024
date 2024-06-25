#!/bin/sh

# Create the "out" directory if it doesn't exist
mkdir -p ./out

# Move all .out from array tasks into out folder
mv inv-array-*.out out/

cd out

# read in data 
cat inv-array-* >> final_array_result.out

# clean up by removing individual out files
rm inv-array-*.out
