#!/bin/bash
set -e

INTERFACE=$(nmcli -t -f DEVICE,TYPE c show --active | grep wireless | cut -d: -f1 | head -n 1)
LABEL=""

if [ -n "${INTERFACE}" ]; then
    SSID=$(nmcli -t -f NAME,DEVICE,TYPE c show --active | grep "${INTERFACE}" | cut -d: -f1)
fi

if [ -n "${INTERFACE}" ]; then
    if [ -n "${SSID}" ]; then
        echo "${LABEL} ${SSID}"
    else
        echo "${LABEL} disconnected"
    fi
else
    echo ""
fi
