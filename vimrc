set nocompatible

runtime macros/matchit.vim

augroup mygroup
    autocmd!
augroup END

filetype plugin indent on
syntax on
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set tabstop=4
set backspace=indent,eol,start
set ruler
set autoread
set laststatus=1
set hlsearch
set incsearch
set wildmenu
set showcmd
set hidden
set linebreak
set foldmethod=marker
set splitbelow
set splitright
set complete-=it
set showtabline=0
set ttimeout
set ttimeoutlen=50

set path+=src/**/*

if has('nvim')
    set inccommand=nosplit
    set undofile
else
    if empty($XDG_DATA_HOME)
        let $XDG_DATA_HOME = $HOME . '/.local/share'
    endif

    if isdirectory($XDG_DATA_HOME . '/vim/swap/')
        set directory=$XDG_DATA_HOME/vim/swap//
    endif

    if isdirectory($XDG_DATA_HOME . '/vim/undo/')
        set undofile
        set undodir=$XDG_DATA_HOME/vim/undo/
    endif

    runtime ftplugin/man.vim
    set keywordprg=:Man
endif

let mapleader = "\<Space>"
let maplocalleader = ','

set wildcharm=<C-z>

map Y y$ 

nnoremap <Leader>f :edit **/*<C-z><S-Tab>
nnoremap <Leader>e :edit %:h<C-z>
nnoremap <LocalLeader>m :make<CR>:cwindow<CR>:cc<CR><ESC>
nnoremap <LocalLeader>a :cp<CR>
nnoremap <LocalLeader>s :cn<CR>
nnoremap <LocalLeader>q :cc<CR>
nnoremap <LocalLeader>d :%s/\s\+$//<CR>

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
nnoremap <Leader>n :call RenameFile()<CR>

if has('mac')
    set path-=/usr/include
    let &path .= ',' . system("xcrun --show-sdk-path | tr -d '\n'") . '/usr/include'
endif

let g:clojure_fuzzy_indent_patterns = [
  \ '^with', '^def', '^let', '^comment', '^loop', '^go-loop', '^while',
  \ '^reg-sub', '^do', '^try', '^cond'
  \ ]
let g:clojure_align_subforms = 1

let g:netrw_banner = 0

nnoremap <F10> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
\ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
\ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

autocmd mygroup BufNewFile,BufRead todo-work.txt set filetype=todo
