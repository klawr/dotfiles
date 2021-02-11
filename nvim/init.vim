set nocompatible

if !exists('g:vscode')

    source $LOCALAPPDATA\nvim\plugins.vim

    syntax enable
    colorscheme gruvbox

    nnoremap <SPACE> <Nop>
    let mapleader = " "
    nnoremap - <Nop>
    " let maplocalleader = "-"
    nnoremap - /

    nnoremap <Leader>f :find
    nnoremap <Leader><Esc> :noh<CR>

    " Open and source init.vim: READONLY IN VSCODE...TEST IT YOU WILL SEE WHY.
    :nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
    :nnoremap <Leader>sv :source $MYVIMRC<cr>

    " Echo complete file path:
    nnoremap <Leader>p :echo expand('%:p')<CR>

    " Escape with jj in insert mode
    " THIS DOES NOT WORK IN VSCODE-NEOVIM.
    " ADD THIS TO keybindings.json:
    " {
    "   "command": "vscode-neovim.compositeEscape1",
    "   "key": "j",
    "   "when": "neovim.mode == insert && editorTextFocus",
    "   "args": "j"
    " }
    inoremap jj <Esc>
    " Jump to marks using ,
    nnoremap , `
    nnoremap ,, ``

    " Set mark z, clean all whitespaces, reindent whole buffer
    " Move back to z, center cursor and remove highlights on whitespaces
    nnoremap <A-F> mz:%s/\s\+$//e<CR>gg=G<CR>`zzz:noh<CR>
    " Close window
    nnoremap qq :q<CR>

    " # is for 'alternate file name'. ¯\_(ツ)_/¯
    nnoremap # :
    nnoremap ! :!

    " Open new empty tab
    nnoremap <A-t> :tabnew<Cr><Cr>
    " Iterate from 0 to 10 for keybinds
    let count = 1
    while count <= 10
        " 10 must evaluate to 0
        let n = count % 10
        " Go to tab number n using <A-n>
        exe 'nnoremap' '<A-'.n.'>' n.'gt'
        let count += 1
    endwhile

    " Set pwsh as default shell
    set shell=powershell.exe
    set shellcmdflag=-NoLogo\ -NonInteractive\ -Command
    set shellpipe=!
    set shellredir=>

    vnoremap <RightMouse> "*y
    nnoremap <RightMouse> "*p<CR>
    inoremap <RightMouse> <Esc>"*pa

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

    source $LOCALAPPDATA/nvim/coc.vim
endif

source $LOCALAPPDATA/nvim/pok3r.vim

