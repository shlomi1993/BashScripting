#!/bin/bash
# Shlomi Ben-Shushan

# Arguments check.
if [ "$#" -lt 3 ]
then
    echo "Not enough parameters"
    exit
fi

# Get arguments.
dir=$1
type=$2
pattern=$3

# Fix dir.
if [[ $dir == "./"* ]]
then
    dir=${dir#$"./"}
fi

# Select the wanted files in a lexicographical order.
files=$(find $dir -maxdepth 1 -type f -name "*.$type" | cut -f 1 -d '.' | sort -d)

# Using grep for each selected file.
for file in $files
do
    grep -w "${pattern}" -i $file.$type
done
