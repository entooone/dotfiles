
" General
"─────────────────────────────
set encoding=utf-8
set nobomb
scriptencoding utf-8
filetype plugin indent on
syntax on
set hlsearch
set ignorecase
set smartcase
set autoindent
set wildmenu
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smarttab
set backspace=indent,eol,start
set clipboard=unnamed
set visualbell t_vb=
set history=5000
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=single
set conceallevel=0
set splitbelow
set noruler
set nonumber
set noshowcmd
set noshowmode
set nowrap
set showtabline=2
set guioptions-=e
set laststatus=0
let mapleader = "\<Space>"
if !has('gui_running')
    set t_Co=256
endif


" Cursor
"─────────────────────────────
if has('vim_starting')
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif


" KeyMap
"─────────────────────────────
autocmd BufNewFile,BufRead *.txt nnoremap j gj
autocmd BufNewFile,BufRead *.txt nnoremap k gk
autocmd BufNewFile,BufRead *.txt vnoremap j gj
autocmd BufNewFile,BufRead *.txt vnoremap k gk
autocmd BufNewFile,BufRead *.md nnoremap j gj
autocmd BufNewFile,BufRead *.md nnoremap k gk
autocmd BufNewFile,BufRead *.md vnoremap j gj
autocmd BufNewFile,BufRead *.md vnoremap k gk
nnoremap Y y$
nnoremap <C-H> gT
nnoremap <C-L> gt


" netrw
"─────────────────────────────
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Plugin
"─────────────────────────────
call plug#begin('~/.vim/plugged')
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'fatih/molokai'
Plug 'easymotion/vim-easymotion'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()


" neosnippet
"─────────────────────────────
imap <C-k>       <Plug>(neosnippet_expand_or_jump)
xmap <C-k>       <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?


" molokai
"─────────────────────────────
augroup TransparentBG
    autocmd!
    autocmd Colorscheme * highlight Normal           ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight VertSplit        ctermbg=NONE guibg=NONE ctermfg=238 
    autocmd Colorscheme * highlight NonText          ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight LineNr           ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight Folded           ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight EndOfBuffer      ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight Error            ctermbg=NONE guibg=NONE cterm=underline
    autocmd Colorscheme * highlight Todo             ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight ToolbarButton    ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight StatusLine       ctermbg=NONE guibg=NONE ctermfg=238 cterm=none
    autocmd Colorscheme * highlight StatusLineNC     ctermbg=NONE guibg=NONE ctermfg=238 cterm=none
    autocmd Colorscheme * highlight StatusLineTerm   ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight StatusLineTermNC ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight SignColumn       ctermbg=NONE guibg=NONE
    autocmd Colorscheme * highlight TabLine          ctermbg=NONE guibg=NONE ctermfg=59 cterm=none
    autocmd Colorscheme * highlight TabLineSel       ctermbg=NONE guibg=NONE cterm=none
    autocmd Colorscheme * highlight TabLineFill      ctermbg=NONE guibg=NONE cterm=none
    autocmd Colorscheme * highlight link GitBranch Special
augroup END
if isdirectory(expand('~/.vim/plugged/molokai'))
    let g:rehash256 = 1
    colorscheme molokai
endif
function! MakeStatusLine() abort
    return repeat('─', winwidth(0))
endfunction

function! s:tabpage_label(n) abort
    let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    let bufnrs = tabpagebuflist(a:n)
    let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '*' : ''
    let sp = ' '
    let current = bufnrs[tabpagewinnr(a:n) - 1]
    let fname = bufname(current)
    let label = a:n . sp . fname . mod
    let label = a:n is tabpagenr() ? '[' . label . ']' : sp . label . sp
    return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction
function! s:get_git_branch() abort
    let branch = system('git symbolic-ref --short HEAD')
    if v:shell_error != 0
        return ''
    endif
    return strpart(branch, 0, strlen(branch)-1)
endfunction
function! MakeTabLine() abort
    let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
    let sep = ''
    let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
    let branch = s:get_git_branch()
    let info = '%#GitBranch#' . branch
    return  tabpages .  '%=' . info
endfunction

set fillchars+=vert:\│
set statusline=%!MakeStatusLine()
set tabline=%!MakeTabLine()


" easymotion
"─────────────────────────────
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map  <leader>s <Plug>(easymotion-bd-f)
nmap <leader>s <Plug>(easymotion-overwin-f)

" asyncomplete
"─────────────────────────────
let g:asyncomplete_auto_popup = 0
imap <C-L> <Plug>(asyncomplete_force_refresh)


" command
"─────────────────────────────
nmap <leader>r :<C-u>source ~/.vimrc<CR>
nmap <leader>g :<C-u>terminal ++close tig<CR>
nmap <leader>e :<C-u>Se<CR>
