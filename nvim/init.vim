language en
set nocompatible

if !exists('g:vscode')
    call plug#begin("~/.vim/plugged")
    Plug 'rakr/vim-one'
    Plug 'morhetz/gruvbox'
    Plug 'preservim/nerdcommenter'
    "Plug 'sheerun/vim-polyglot'
    Plug 'frazrepo/vim-rainbow'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
                \ 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver',
                \ 'coc-powershell', 'coc-vimtex'
                \ ]
    Plug 'mg979/vim-visual-multi', {'branch': 'master'},
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    call plug#end()

    " ************************************************************
    " End at line 150
    " Coc configs edited from https://github.com/neoclide/coc.nvim
    "
    " ************************************************************

    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("patch-8.1.1564")
        " Recently vim can merge signcolumn and number column into one
        set signcolumn=number
    else
        set signcolumn=yes
    endif

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    " Use <c-space> to trigger completion.
    if has('nvim')
        inoremap <silent><expr><c-space> <Esc>coc#refresh()a
    else
        inoremap <silent><expr> <c-@> coc#refresh()
    endif

    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " GoTo code navigation.
    nnoremap <silent> gd <Plug>(coc-definition)
    nnoremap <silent> gy <Plug>(coc-type-definition)
    nnoremap <silent> gi <Plug>(coc-implementation)
    nnoremap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
            call CocActionAsync('doHover')
        else
            execute '!' . &keywordprg . " " . expand('<cword>')
        endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    nnoremap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    " nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list/.
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

    " Coc finished

    nnoremap <F2> <Plug>(coc-rename)
    inoremap <F2> <Esc><Plug>(coc-rename)a

    " Hide mode, because lightline already does it
    " set noshowmode
    " Set minimum height windows to 0
    set wmh=0

    " ****************************************************************
    "
    " COC config end
    "
    " ****************************************************************

    " For colorscheme
    if (has("termguicolors"))
        set termguicolors
    endif
    syntax enable
    "colorscheme one
    colorscheme gruvbox
    set background=dark

    " ...
    function! OpenTerminal()
        split
        term
        startinsert
        resize 12
    endfunction

    " Open new split panes to the right and below
    set splitright
    set splitbelow

    " Autocommands:
    augroup autocommands
        " Clearing to avoid duplicating autocommands
        autocmd!
        autocmd VimEnter * source $MYVIMRC
        " Start terminal in insert mode
        autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
        " ...
        " autocmd VimEnter * call ToggleNERD()
        " Automatically close if NERDTree is only thing left open
        " autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END

    " Mappings:

    " Leader Mappings:
endif

" FOLLOWING STUFF IS FOR NEOVIM IN VSCODE TOO:

nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap - <Nop>
let maplocalleader = "-"

nnoremap <Leader><Esc> :noh<CR>
nnoremap <Leader>v viw

" Open and source init.vim: READONLY IN VSCODE...TEST IT YOU WILL SEE WHY.
:nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <Leader>sv :source $MYVIMRC<cr>

" Echo complete file path:
nnoremap <Leader>n :echo expand('%:p')<CR>

" Open terminal:
nnoremap <C-n> :call OpenTerminal()<CR>
" Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" Escape with jj in insert mode
inoremap jj <Esc>
" Jump to marks using ,
nnoremap , `
nnoremap ,, ``

" Set mark z, clean all whitespaces, reindent whole buffer
" Move back to z, center cursor and remove highlights on whitespaces
if !exists('g:vscode')
    nnoremap <A-F> mz:%s/\s\+$//e<CR>gg=G<CR>`zzz:noh<CR>
endif
" Close window
nnoremap qq :q<CR>

" Activate Rolodex mode
" nnoremap <C-m> :set winheight=999<CR>

" # is for 'alternate file name'. ¯\_(ツ)_/¯
nnoremap # :
nnoremap ! :!

fu Remap(type, lhs, rhs)
    exe a:type.'noremap' a:lhs a:rhs
endfu

" Movement mappings:

" hjki have to be turned to work with the pok3r arrow maps
" The arrow keys define the new positions
" i and h are switched accordingly
let poker = ['h', 'j', 'k', 'i']
" Replace all these movement mappings with poker style:
let mvmap = [
            \ ['<C-\><C-n><C-w>', ''],
            \ ['<C-w>', ''],
            \ ['<S-', '>'],
            \ ['', '']
            \ ]
let index = len(poker) - 1
while index >= 0
    let t = poker[index]
    let s = poker[index - 1]
    " Remap default movement keys
    for m in mvmap
        call Remap('n', m[0].t.m[1], m[0].s.m[1])
        call Remap('v', m[0].t.m[1], m[0].s.m[1])
        call Remap('o', m[0].t.m[1], m[0].s.m[1])
    endfor

    " Custom movement mappings:
    " Move from terminal to the window in the respective direction
    call Remap('t', '<C-'.t.'>', '<C-\><C-n><C-w>'.s)
    " Same for moving from normal mode
    " Alt + arrows is moving in windows terminal
    call Remap('n', '<A-'.t.'>', '<C-w>'.s)
    let index -= 1
endwhile

" Remap l for custom mappings:
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-l> <C-w>l

" Next and previous tab
nnoremap <C-J> gT
nnoremap <C-L> gt

" Next and previous buffer
nnoremap <C-j> :bp<CR>
nnoremap <C-l> :bn<CR>

nnoremap <Leader>b :ls<CR>

" Iterate from 0 to 10 for keybinds
let count = 1
while count <= 10
    " 10 must evaluate to 0
    let n = count % 10
    " Open Buffer nr n using <Fn>
    call Remap('n', '<Leader>'.n, ':'.n.'b<CR>')
    " Go to tab number n using <A-n>
    call Remap('n', '<A-'.n.'>', n.'gt')
    let count += 1
endwhile

" Move split panes left, right, up and down
nnoremap <S-Left> <C-w><S-h>
nnoremap <S-Right> <C-w><S-l>
nnoremap <S-Up> <C-w><S-j>
nnoremap <S-Down> <C-w><S-k>

" Set pwsh as default shell
set shell=powershell.exe
set shellcmdflag=-NoLogo\ -NonInteractive\ -Command
set shellpipe=!
set shellredir=>

set clipboard=unnamed " Use system clipboard
vnoremap <RightMouse> y
nnoremap <RightMouse> p
inoremap <RightMouse> <Esc>:normal p<CR>a

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
set showtabline=2 " 0 Always show tabline

syntax enable

" https://stackoverflow.com/questions/94382/vim-with-powershell
if has("win32")
    set shell=cmd.exe
    set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive\ -ExecutionPolicy\ RemoteSigned
    set shellpipe=|
    set shellredir=>
endif
