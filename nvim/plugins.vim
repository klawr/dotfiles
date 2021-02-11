
call plug#begin("~/.vim/plugged")
    Plug 'morhetz/gruvbox'
    "Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'mg979/vim-visual-multi', {'branch': 'master'},
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'lervag/vimtex'
    Plug 'pprovost/vim-ps1'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
call plug#end()

let g:tex_flavor = 'latex'
