set nocompatible

syntax enable
colorscheme gruvbox

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup end

function! NetrwMapping()
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
set smartindent
set smarttab
set softtabstop=4
set expandtab
set linebreak
set showtabline=1 " 0 Always show tabline
set path+=**
set wildignore+=**/node_modules/**

filetype plugin on
