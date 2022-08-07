
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
set tabstop=4
set shiftwidth=0
set softtabstop=0
set expandtab
set smarttab
set backspace=indent,eol,start
set clipboard=unnamed
set visualbell t_vb=
set history=5000
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,utf-16le,euc-jp,cp932,sjis
set fileformats=unix,dos,mac
set ambiwidth=single
set conceallevel=0
set splitbelow
set ruler
set nonumber
set noshowcmd
set noshowmode
set nowrap
set showtabline=2
set guioptions-=e
set laststatus=0
if !has('gui_running')
    set t_Co=256
endif
set noswapfile

"
" Windows
"─────────────────────────────
if has('win32')
    set runtimepath^=~/.vim/
endif

" Cursor
"─────────────────────────────
if has('vim_starting')
    let &t_SI .= "\<esc>[6 q"
    let &t_EI .= "\<esc>[2 q"
    let &t_SR .= "\<esc>[4 q"
endif


" StatusLine / TabLine
"─────────────────────────────
func! MakeStatusLine() abort
    return repeat('─', winwidth(0))
endfunc
set fillchars+=vert:\│
set statusline=%!MakeStatusLine()


" netrw
"─────────────────────────────
func! NetrwMapping_gt(islocal) abort
  return "normal! gt"
endfunc
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:Netrw_UserMaps = [
\   ['<C-l>', 'NetrwMapping_gt'],
\ ]


" Plugin
"─────────────────────────────
call plug#begin('~/.vim/plugged')
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'fatih/molokai'
Plug 'easymotion/vim-easymotion'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'
Plug 'mattn/vim-goimpl'
Plug 'hashivim/vim-terraform'
Plug 'cespare/vim-toml'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-matchfuzzy'
Plug 'mattn/vim-maketable'
Plug 'koron/codic-vim'
Plug 'ziglang/zig.vim'
call plug#end()


" lsp-settings
"─────────────────────────────
if has('win32') || has('win64')
    let g:lsp_settings_servers_dir = expand('$HOMEPATH/.local/share/vim-lsp-settings/servers')
endif


" lsp
"─────────────────────────────
function! s:handle_rename_prepare(server, last_command_id, type, data) abort
    if a:last_command_id != lsp#_last_command()
        return
    endif

    if lsp#client#is_error(a:data['response'])
        call lsp#utils#error('Failed to retrieve '. a:type . ' for ' . a:server . ': ' . lsp#client#error_message(a:data['response']))
        return
    endif

    let l:range = a:data['response']['result']
    let l:lines = getline(1, '$')
    let [l:start_line, l:start_col] = lsp#utils#position#lsp_to_vim('%', l:range['start'])
    let [l:end_line, l:end_col] = lsp#utils#position#lsp_to_vim('%', l:range['end'])
    if l:start_line ==# l:end_line
        let l:name = l:lines[l:start_line - 1][l:start_col - 1 : l:end_col - 2]
    else
        let l:name = l:lines[l:start_line - 1][l:start_col - 1 :]
        for l:i in range(l:start_line, l:end_line - 2)
            let l:name .= "\n" . l:lines[l:i]
        endfor
        if l:end_col - 2 < 0
            let l:name .= "\n"
        else
            let l:name .= l:lines[l:end_line - 1][: l:end_col - 2]
        endif
    endif

    call timer_start(1, {x->s:rename(a:server, input('new name: ', l:name), l:range['start'])})
endfunction

function! s:handle_workspace_edit(server, last_command_id, type, data) abort
    if a:last_command_id != lsp#_last_command()
        return
    endif

    if lsp#client#is_error(a:data['response'])
        call lsp#utils#error('Failed to retrieve '. a:type . ' for ' . a:server . ': ' . lsp#client#error_message(a:data['response']))
        return
    endif

    call lsp#utils#workspace_edit#apply_workspace_edit(a:data['response']['result'])

    echo 'Renamed'
endfunction

function! s:rename(server, new_name, pos) abort
    if empty(a:new_name)
        echo '... Renaming aborted ...'
        return
    endif

    " needs to flush existing open buffers
    call lsp#send_request(a:server, {
        \ 'method': 'textDocument/rename',
        \ 'params': {
        \   'textDocument': lsp#get_text_document_identifier(),
        \   'position': a:pos,
        \   'newName': a:new_name,
        \ },
        \ 'on_notification': function('s:handle_workspace_edit', [a:server, lsp#_last_command(), 'rename']),
        \ })

    echo ' ... Renaming ...'
endfunction

function! s:fast_rename(new_name) abort
    let l:servers = filter(lsp#get_allowed_servers(), 'lsp#capabilities#has_rename_prepare_provider(v:val)')
    let l:prepare_support = 1
    if len(l:servers) == 0
        let l:servers = filter(lsp#get_allowed_servers(), 'lsp#capabilities#has_rename_provider(v:val)')
        let l:prepare_support = 0
    endif

    let l:command_id = lsp#_new_command()

    if len(l:servers) == 0
        call s:not_supported('Renaming')
        return
    endif

    " TODO: ask the user which server it should use to rename if there are multiple
    let l:server = l:servers[0]

    if l:prepare_support
        call lsp#send_request(l:server, {
            \ 'method': 'textDocument/prepareRename',
            \ 'params': {
            \   'textDocument': lsp#get_text_document_identifier(),
            \   'position': lsp#get_position(),
            \ },
            \ 'on_notification': function('s:handle_rename_prepare', [l:server, l:command_id, 'rename_prepare']),
            \ })
        return
    endif
    call s:rename(l:server, a:new_name, lsp#get_position())
endfunction
command! ToUpperCase call s:fast_rename(substitute(expand("<cword>"), "^.", "\\U&", "g"))
command! ToLowerCase call s:fast_rename(substitute(expand("<cword>"), "^.", "\\L&", "g"))


" neosnippet
"─────────────────────────────
let g:neosnippet#snippets_directory='~/.vim/snippets'


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
    autocmd Colorscheme * highlight WarningMsg       ctermbg=NONE guibg=NONE ctermfg=222 cterm=bold
    autocmd Colorscheme * highlight link GitBranch   Special
    autocmd Colorscheme * highlight link ProjectPath PreProc
augroup END
if isdirectory(expand('~/.vim/plugged/molokai'))
    let g:rehash256 = 1
    colorscheme molokai
endif


" easymotion
"─────────────────────────────
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1


" asyncomplete
"─────────────────────────────
let g:asyncomplete_auto_popup = 0


" vim-terraform
"─────────────────────────────
let g:terraform_fmt_on_save = 1


" ctrlp
"─────────────────────────────
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_show_hidden = 1


" keymap
"─────────────────────────────
let mapleader = "\<Space>"
nnoremap          Q           :<C-u>q<CR>
nnoremap          Y           y$
nnoremap          <C-H>       gT
nnoremap          <C-L>       gt
imap              <C-L>       <Plug>(asyncomplete_force_refresh)
imap              <C-k>       <Plug>(neosnippet_expand_or_jump)
xmap              <C-k>       <Plug>(neosnippet_expand_target)
smap              <expr><TAB> neosnippet#expandable_or_jumpable() ?
nnoremap <silent> <leader>s   :<C-u>NeoSnippetEdit -split -horizontal<CR>
map               <leader>m   <Plug>(easymotion-bd-f)
nmap              <leader>m   <Plug>(easymotion-overwin-f)
nmap     <buffer> <leader>n   <plug>(lsp-references)
nnoremap <silent> <leader>R   :<C-u>source ~/.vimrc<CR>
nnoremap <silent> <leader>g   :<C-u>terminal ++close tig<CR>
nnoremap <silent> <leader>b   :<C-u>CtrlPBuffer<CR>
"nnoremap <silent> <leader>b   :<C-u>execute('terminal ++close tig blame +' . line('.') . ' ' . expand('%:p'))<CR>
nnoremap <silent> <leader>e   :<C-u>Texplore<CR>
nnoremap <silent> <leader>t   :<C-u>terminal<CR>
nnoremap <silent> <leader>h   :<C-u>LspHover<CR>
nnoremap <silent> <leader>d   :<C-u>LspDefinition<CR>
nnoremap <silent> <leader>p   :<C-u>LspDocumentDiagnostics<CR>
nnoremap <silent> <leader>w   :<C-u>LspDocumentSymbol<CR>
nnoremap <silent> <leader>r   :<C-u>LspReferences<CR>
nnoremap          <leader>SS  :<C-u>SaveSession<CR>
nnoremap <silent> <leader>SL  :<C-u>CtrlPLoadSession<CR>
nnoremap <silent> <leader>SD  :<C-u>CtrlPDeleteSession<CR>
nnoremap <silent> <leader>U   :<C-u>ToUpperCase<CR>
nnoremap <silent> <leader>u   :<C-u>ToLowerCase<CR>
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <M-B> <S-Left>
cnoremap <M-J> <S-Right>

" automatic commands
"─────────────────────────────
augroup TxtConf
    autocmd!
    autocmd BufNewFile,BufRead *.txt nnoremap j gj
    autocmd BufNewFile,BufRead *.txt nnoremap k gk
    autocmd BufNewFile,BufRead *.txt vnoremap j gj
    autocmd BufNewFile,BufRead *.txt vnoremap k gk
augroup END
augroup MdConf
    autocmd!
    autocmd BufNewFile,BufRead set noexpandtab
    autocmd BufNewFile,BufRead *.md nnoremap j gj
    autocmd BufNewFile,BufRead *.md nnoremap k gk
    autocmd BufNewFile,BufRead *.md vnoremap j gj
    autocmd BufNewFile,BufRead *.md vnoremap k gk
augroup END
augroup TEXConf
    autocmd!
    autocmd BufWritePre *.tex :%s/、/，/ge
    autocmd BufWritePre *.tex :%s/。/．/ge
    autocmd BufNewFile,BufRead *.tex set wrap
    autocmd BufNewFile,BufRead *.tex nnoremap j gj
    autocmd BufNewFile,BufRead *.tex nnoremap k gk
    autocmd BufNewFile,BufRead *.tex vnoremap j gj
    autocmd BufNewFile,BufRead *.tex vnoremap k gk
    "autocmd BufNewFile,BufRead *.tex inoremap ; \
augroup END
