execute pathogen#infect()

set nocompatible

runtime macros/matchit.vim

augroup mygroup
    autocmd!
augroup END

" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set nomodeline

" These are nvim defaults that are not defaults in vim
filetype plugin indent on
syntax on
set autoindent
set smarttab
set backspace=indent,eol,start
set ruler
set autoread
set laststatus=2
set hlsearch
set wildmenu
set showcmd

set hidden
set linebreak
set winwidth=90
set foldmethod=marker
set splitbelow
set splitright
set complete-=it
set guicursor=
set showtabline=0

set expandtab
set shiftwidth=4
set softtabstop=4

if has('nvim')
    set inccommand=nosplit
    set termguicolors
    colorscheme onedark
    let s:colors = onedark#GetColors()
    let g:rainbow_conf = {
      \ 'guifgs': [s:colors.purple.gui, s:colors.blue.gui, s:colors.green.gui]
      \ }
endif

let mapleader = ","
let maplocalleader = "\<Space>"

set wildcharm=<C-z>
nnoremap <Leader>e :edit **/*<C-z><S-Tab>
nnoremap <Leader>f :find **/*<C-z><S-Tab>
nnoremap <Leader>h :edit %:h<C-z>
nnoremap gb :ls<CR>:b<Space>
nnoremap <Leader>t :tabs<CR>:tabn<Space>

nnoremap <F4> :nohl<CR>

" Deletes all trailing whitespace in a file
nnoremap <Leader>d :%s/\s\+$//<CR>

" Renames the current file
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
    let &path .= "," . system("xcrun --show-sdk-path | tr -d '\n'") . "/usr/include"
endif

" Rainbow (mostly for clojure)
let g:rainbow_active = 0
autocmd mygroup BufNewFile,BufRead
            \ *.clj,*.cljs,*.cljc,*.edn,*.scm,*.lisp,*.rkt
            \ RainbowToggleOn

let g:clojure_fuzzy_indent_patterns = [
  \ '^with', '^def', '^let', '^comment', '^loop', '^go-loop', '^while',
  \ '^reg-sub', '^do', '^try', '^cond'
  \ ]
let g:clojure_align_subforms = 1

let g:ale_lint_on_text_changed = 'never'
nnoremap <F5> :ALEToggleBuffer<CR>

let g:netrw_banner = 0

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
