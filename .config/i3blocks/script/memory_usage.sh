#!/bin/bash
set -e

MEM_TOTAL=$(free -b | awk 'NR==2{print $2}')
MEM_USED=$(free -b | awk 'NR==2{print $3}')

MEM_PERCENT=$((100 * MEM_USED / MEM_TOTAL))

echo " ${MEM_PERCENT}%"
