scd() {
    dir=$(find ${1:-\.} -type d | fzf --height 40% --reverse)
    if [ $? -eq 0 ]; then
        cd $dir
        ls
    fi
}
