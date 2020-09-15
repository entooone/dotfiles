function! g:GoReturn() abort
    let bpos = wordcount()['cursor_bytes']
    let out = system('goreturn -pos ' . bpos, bufnr('%'))
    if v:shell_error != 0
        return ''
    endif
    return strpart(out, 0, strlen(out)-1)
endfunction
