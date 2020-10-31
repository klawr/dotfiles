" https://github.com/junegunn/vim-plug
call plug#begin("~/.vim/plugged")
    " Theme
    Plug 'dracula/vim'
    Plug 'git@github.com:rakr/vim-one.git'
    Plug 'git@github.com:morhetz/gruvbox.git'
    " NERDTree and Icons
    Plug 'scrooloose/nerdtree'
    " Plug 'ryanoasis/vim-devicons'
    " Rainbow colors for brackets
    Plug 'frazrepo/vim-rainbow'
    " Fuzzyfinder
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    " Plug 'git@github.com:ggreer/the_silver_searcher.git'
    " Plug 'https://github.com/k-takata/the_silver_searcher-win32.git'  
    " Syntax highlighting   
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
    \ 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver',
    \ 'coc-powershell', 'coc-vimtex'
    \ ]
    " git
    Plug 'git@github.com:tpope/vim-fugitive.git'
    Plug 'git@github.com:airblade/vim-gitgutter.git'

    Plug 'git@github.com:itchyny/lightline.vim.git'

    " Syntax checking
    Plug 'git@github.com:dense-analysis/ale.git'
    " LaTeX
    Plug 'lervag/vimtex'
call plug#end()

" Change guicursor to underscore in normal mode:
" Default : n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
" set guicursor=v-c-sm:block,i-ci-ve:ver25,n-r-cr-o:hor20

" Hide mode, because lightline already does it
set noshowmode

let g:tex_flavor = 'latex'

let g:rainbow_active = 1
" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

function! ToggleNERD()
    NERDTreeToggle
    " Keep the focus on active window
    wincmd p
endfunction
nnoremap <silent> <C-b> :call ToggleNERD()<CR>

" autocmd VimEnter * call ToggleNERD()
" Automatically close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" For colorscheme
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme one
set background=dark

" Fuzzyfinder
" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
" let $FZF_DEFAULT_COMMAND = "ag -g ''"

" Open new split panes to right and below
set splitright
set splitbelow
" Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" Open terminal on ctrl+ö
function! OpenTerminal()
    split term://pwsh
    resize 12
endfunction
nnoremap <C-n> :call OpenTerminal()<CR>
" Activate Rolodex mode
" nnoremap <C-m> :set winheight=999<CR>

nnoremap <SPACE> <Nop>
let mapleader = " "

" default vim: hjkl - left, down, up, right
" Change hotkeys for the Pok3r

fu! Remap(type, lhs, rhs)
    exe a:type.'noremap' a:lhs a:rhs
endfu

" hjki have to be turned to work with the pok3r arrow maps
" The arrow keys define the new positions
" i and h are switched accordingly
let poker = ['h', 'j', 'k', 'i']
let index = len(poker) - 1
while index >= 0
    let t = poker[index]
    let s = poker[index - 1]
    " Move from terminal to the window in the respective direction
    call Remap('t', '<C-'.t.'>', '<C-\><C-n><C-w>'.s.'<CR>')
    " Same for moving from normal mode
    call Remap('n', '<C-'.t.'>', '<C-w>'.s.'<CR>')
    " TODO check what this was
    call Remap('n', '<S-'.t.'>', '<S-'.s.'><CR>')
    " Remap the movement keys
    call Remap('n', t, s)
    let index -= 1  
endwhile

" Remap for l where necessary
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-l> <C-w>l

" Iterate from 0 to 10 for keybinds
let count = 1
while count <= 10
    let n = count % 10
    " Go to tab number n using <A-n>
    call Remap('n', '<A-'.n.'>', n.'gt')
    let count += 1
endwhile

" Next and previous tab
nnoremap <A-j> gT
nnoremap <A-l> gt

" Move split panes left, right, up and down
nnoremap <S-Left> <C-w><S-h>
nnoremap <S-Right> <C-w><S-l>
nnoremap <S-Up> <C-w><S-j>
nnoremap <S-Down> <C-w><S-k>

" TODO Experimental:

fu! MoveToTab(a)
    let tabcnt = tabpagenr('$')
    let curtab = tabpagenr()
    if (a:a > tabcnt + 1)
        echo "Invalid tab number"a:a
    elseif (a:a == curtab)
        echo "You are at tab"a:a
    else
        let buffer = @%
        exe 'tabn' a:a
        exe 'tabn' curtab
        q
        exe 'tabn' a:a
        exe 'vsplit' buffer
    endif
endfu

let c=1
while c <= 10
    let d = c % 10
    execute 'nnoremap <Leader>'.d ':call MoveToTab('.d.')<CR>'
    let c += 1
endwhile
"nnoremap <Leader>1 :call MoveToTab(1)<CR>

" Settings: 

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
