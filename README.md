# BashScripting

This repository documents bash scripting training as part of Operation Systems course I took at Bar-Ilan University.

### ex21.sh

This script gets folder path, file type, and a not-empty word.
The script read each file in the given folder from the given type and prints the lines contains the given word.


### ex22.sh

This script gets folder path, file type, a not-empty word and an non-negative integer number.
The script read each file from the given type in the given folder and its sub-folders and prints the lines that are greater or equal to the given number, <b>and</b> contains the given word.
Note that line size is definied by the number of words it contains.
This script uses ex1.sh script.


### ex23.sh

This script gets a string "host" or "system" and some flags.
If the given string is "host", then the script prints the lines from the file "hostnamectl" according to the given flags. If there are no flags in the command, it prints all the lines from "hostnamectl" file.
if the given string is "system", then the script prints the lines from the file "os-release" according to the given flags. If there are no flags in the command, it prints all the lines from "os-release" file.
The files "hostnamectl" and "os-release" are located in the attached zip named "ex2_resources.zip".
