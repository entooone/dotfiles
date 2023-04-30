#!/bin/bash
set -e

WINDOW_TITLE=$(i3-msg -t get_tree | jq "recurse(.nodes[]?, .floating_nodes[]?) | select(.focused==true).name" | tr -d '"')
echo " -- ${WINDOW_TITLE} -- "
