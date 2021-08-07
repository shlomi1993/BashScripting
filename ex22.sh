#!/bin/bash
# Shlomi Ben-Shushan

# Arguments check.
if [ "$#" -lt 4 ]
then
    echo "Not enough parameters"
    exit
fi

# Get arguments.
dir=$1
type=$2
pattern=$3
number=$4

# Select folders in a lexicographical order.
folders=$(find $dir -type d | sort -d)

# Traverse folders.
for folder in $folders
do
    # Run ex21.sh script on each folder.
    temp=$(./ex21.sh $folder $type $pattern)

    # Split ex21.sh to lines.
    while IFS= read lines
    do
        # Print each line only if its size is at least $number argument.
        for line in "${lines}"
        do
            # Special case whan $number is zero, avoid printing blank lines.
            word_count=$(echo "$line" | wc -w)
            if [ "$number" -ne 0 -a "$word_count" -ge "$number" ]
            then
                echo $line
            elif [ "$number" -eq 0 -a "$word_count" -gt "$number" ]
            then
                echo $line
            fi
        done
    done <<< "$temp"
done
