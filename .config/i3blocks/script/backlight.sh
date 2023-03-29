#!/bin/bash
set -e

case "${BLOCK_BUTTON}" in
    4)
        ~/dotfiles/bin/polybar-light up 1
        ;;
    5)
        ~/dotfiles/bin/polybar-light down 1
        ;;
    *)
        ~/dotfiles/bin/polybar-light initial
esac
