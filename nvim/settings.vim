" set nocompatible

syntax enable
colorscheme gruvbox

let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_liststyle=1
let g:netrw_sizestyle="h"
let g:netrw_bufsettings = "nu"

augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call NetrwSettings()
augroup end

function! NetrwSettings()
    noremap <buffer> i k
endfunction

" other settings:
set relativenumber
set mouse=a
set number      " Show Linenumbers
set showmatch   " Show matching closing bracket
set spell       " Spellchecking

set autoindent
set shiftwidth=4
set smarttab
set softtabstop=4
set expandtab
set linebreak
set showtabline=1 " 0 Always show tabline
set path+=.,**

set wildignore+=*/node_modules/*

filetype plugin on
