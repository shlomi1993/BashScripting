#!/bin/bash
# Shlomi Ben-Shushan

# Arguments check.
if [ "$#" -lt 1 ]
then
    echo "Invalid input"
    exit
fi

# Setup output variable.
output=""

# Setup usage-flags -- set to 1 when a property is appended to output.
name=0
version=0
pretty_name=0
home_url=0
support_url=0
static_hostname=0
icon_name=0
machine_id=0
boot_id=0
virtualization=0
kernel=0
architecture=0

# This function gets a property name and usage-flag.
# If the property information hasn't been added to the output string, it will
# parse the relevant file and add the required data to the output string.
function add_to_output () {

    # If the usage-flag is 1, than the property's value already added.
    if [ $2 == 1 ]
    then
        return
    fi

    # The parsing loop:
    temp=$data
    while IFS= read lines
    do
        # Looking for a line in the file that starts with the property name.
        for line in "${lines}"
        do
            if [[ $line == $1* ]]
            then
                # Once found, it take the data and append if the the output.
                line=${line#$1}
                line=${line#$"\""}
                line=${line%$"\""}
                if [[ $output == $"" ]]
                then
                    output=$(printf "$line")
                else
                    output=$(printf "${output}\n${line}")
                fi
            fi
        done
    done <<< "$temp"
}

# Split to two major cases -- the first arg is "system" or it is "host".
if [ $1 == $"system" ]
then
    # If the first arg is "system" and the second is null, we can print the
    # while file and stop here.
    if [ -z $2 ]
    then
        cat ./os-release
        exit
    fi

    # Else, we have to parse the different flags with switch-case technique.
    data=$(cat ./os-release)
    for arg in "$@"
    do
        # In each case, the usage-flag is passed to determine if to add the
        # property's data to the output, or not.
        case $arg in
            --name)
            add_to_output "NAME=" $name
            name=1
            ;;
            --version)
            add_to_output "VERSION=" $version
            version=1
            ;;
            --pretty_name)
            add_to_output "PRETTY_NAME=" $pretty_name
            pretty_name=1
            ;;
            --home_url)
            add_to_output "HOME_URL=" $home_url
            home_url=1
            ;;
            --support_url)
            add_to_output "SUPPORT_URL=" $support_url
            support_url=1
            ;;
        esac
    done

    # Now we can check, if no flag was valid, the output will be still empty...
    if [[ $output == $"" ]]
    then
        # So we can print all the given file.
        cat ./os-release
    else
        # Else we have an output to print :)
        echo "$output"
    fi

# This case is symmetric to the previous one, but for "host" input.
elif [ $1 == $"host" ]
then
    # If the second arg is null, we can print the file content and stop.
    if [ -z $2 ]
    then
        cat ./hostnamectl
        exit
    fi

    # Else we'll use again the switch-case technique.
    data=$(cat ./hostnamectl)
    for arg in "$@"
    do
        # Each case call add_to_output() with the property and the usage-flag.
        case $arg in
            --static_hostname)
            add_to_output "   Static hostname: " $static_hostname
            static_hostname=1
            ;;
            --icon_name)
            add_to_output "         Icon name: " $icon_name
            icon_name=1
            ;;
            --machine_id)
            add_to_output "        Machine ID: " $machine_id
            machine_id=1
            ;;
            --boot_id)
            add_to_output "           Boot ID: " $boot_id
            boot_id=1
            ;;
            --virtualization)
            add_to_output "    Virtualization: " $virtualization
            virtualization=1
            ;;
            --kernel)
            add_to_output "            Kernel: " $kernel
            kernel=1
            ;;
            --architecture)
            add_to_output "      Architecture: " $architecture
            architecture=1
            ;;
        esac
    done

    # Case no output -- print the whole file.
    if [[ $output == $"" ]]
    then
        cat ./hostnamectl
    # Case yes output -- print it.
    else
        echo "$output"
    fi

# For any other case, the input might be invalid.
else
    echo "Invalid input"
    exit
fi
