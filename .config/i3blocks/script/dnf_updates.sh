#!/bin/bash

upgrades=$(dnf check-upgrade -q | grep -vc '^$')

if [ "$upgrades" -gt 0 ]; then
    echo " $upgrades"
else
    echo ""
fi
