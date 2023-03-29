#!/bin/bash
set -e

LABEL0=
LABEL1=
LABEL2=
LABEL3=
LABEL4=

LABEL=${LABEL4}
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)


if [ "${STATUS}" = "Charging" ]; then
    LABEL=""
    COLOR="#E5C07B"
else
  if [ ${CAPACITY} -ge 80 ]; then
      LABEL=${LABEL4}
      COLOR="#FFFFFF"
  elif [ ${CAPACITY} -ge 60 ]; then
      LABEL=${LABEL3}
      COLOR="#FFFFFF"
  elif [ ${CAPACITY} -ge 40 ]; then
      LABEL=${LABEL2}
      COLOR="#FFFFFF"
  elif [ ${CAPACITY} -ge 20 ]; then
      LABEL=${LABEL1}
      COLOR="#FFFFFF"
  else
      LABEL=${LABEL0}
      COLOR="#E06C75"
  fi
fi

echo "${LABEL} ${CAPACITY}%"
echo "${LABEL} ${CAPACITY}%"
echo "${COLOR}"
