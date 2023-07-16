#!/bin/bash
set -e

LABEL_LEVEL0="🌣"
LABEL_LEVEL1="🌣"
LABEL_LEVEL2="🌣"
LABEL_LEVEL3="🌣"
LABEL_LEVEL4="🌣"
#LABEL_LEVEL0="🌑"
#LABEL_LEVEL1="🌒"
#LABEL_LEVEL2="🌓"
#LABEL_LEVEL3="🌔"
#LABEL_LEVEL4="🌕"

format() {
  local label value

  value=$1

  if [[ "${value}" -lt 10 ]]; then
    label=${LABEL_LEVEL0}
  elif [[ "${value}" -lt 30 ]]; then
    label=${LABEL_LEVEL1}
  elif [[ "${value}" -lt 70 ]]; then
    label=${LABEL_LEVEL2}
  elif [[ "${value}" -lt 100 ]]; then
    label=${LABEL_LEVEL3}
  elif [[ "${value}" -eq 100 ]]; then
    label=${LABEL_LEVEL4}
  fi

  echo "${label} ${value}"
}

backlight() {
  local brightness value diff
  brightness=$(light -G)
  value=${brightness%.*}

  if [[ "$1" == "initial" ]]; then
    :
  elif [[ "$1" == "up" ]]; then
    light -A "$2"
  elif [[ "$1" == "down" ]]; then
    after_value=$(( ${value} - $2 ))
    if [[ "${after_value}" -gt 0 ]]; then
      light -U "$2"
    fi
  fi

  brightness=$(light -G)
  value=${brightness%.*}

  format "${value}"
}

main() {
  case "${BLOCK_BUTTON}" in
    4)
      backlight up 1
      ;;
    5)
      backlight down 1
      ;;
    *)
      backlight initial
  esac
}

main
