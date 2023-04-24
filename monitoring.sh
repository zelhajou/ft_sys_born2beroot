#!/bin/bash

# The architecture of your operating system and its kernel version
# 'uname -a' prints : hardware machine name & info
ARCHITECTURE=$(uname -a)

# The number of physical processors
# lscpu - display information about the CPU architecture
CPU_PHYSICAL=$(lscpu | awk '$1 == "CPU(s):" {print $2}')

# The number of virtual processors
# -c: Only a count of selected lines is written to standard output
vCPU=$(grep -c "^processor" /proc/cpuinfo)

# The current available RAM on the server and its utilization rate as a percentage
# free - Display amount of free and used memory in the system
# -m: display the amount of memory in mebibytes
RAM_TOTAL=$(free -m | grep Mem | awk '{printf("%dMB", $2)}')
RAM_USED=$(free -m | grep Mem | awk '{print $3}')
RAM_PERC=$(free -m | grep Mem | awk '{printf("(%.2f%%)", ($3 * 100) / $2)}')

