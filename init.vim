" https://github.com/junegunn/vim-plug
call plug#begin("~/.vim/plugged")
    " Theme
    Plug 'dracula/vim'
    Plug 'git@github.com:rakr/vim-one.git'
    Plug 'git@github.com:morhetz/gruvbox.git'
    " NERDTree and Icons
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " NERDCommenter
    Plug 'preservim/nerdcommenter'
    " Syntax highlighting
    Plug 'sheerun/vim-polyglot'
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
    " Plug 'pprovost/vim-ps1'
    " git
    Plug 'git@github.com:tpope/vim-fugitive.git'
    Plug 'git@github.com:airblade/vim-gitgutter.git'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " Plug 'itchyny/lightline.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Syntax checking
    Plug 'git@github.com:dense-analysis/ale.git'

    " LaTeX
    Plug 'lervag/vimtex'

    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

" Plugin Configs:

let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#tabline#show_splits = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" Coc:
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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
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

" Symbol renaming.
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

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xnoremap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nnoremap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nnoremap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xnoremap if <Plug>(coc-funcobj-i)
onoremap if <Plug>(coc-funcobj-i)
xnoremap af <Plug>(coc-funcobj-a)
onoremap af <Plug>(coc-funcobj-a)
xnoremap ic <Plug>(coc-classobj-i)
onoremap ic <Plug>(coc-classobj-i)
xnoremap ac <Plug>(coc-classobj-a)
onoremap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
set noshowmode

let g:tex_flavor = 'latex'

let g:rainbow_active = 1
" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeDirArrowExpandable = '' "'▸'
let g:NERDTreeDirArrowCollapsible = '' "'▾'


function! ToggleNERD()
    NERDTreeToggle
    " Keep the focus on active window
    wincmd p
endfunction

" For colorscheme
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme one
set background=dark

" Fuzzyfinder
let g:fzf_action = {
  \ 'enter': 'tab split',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" ...
function! OpenTerminal()
    split term://pwsh
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
    autocmd VimEnter * call ToggleNERD()
    " Automatically close if NERDTree is only thing left open
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" Mappings:
 
" Leader Mappings:

nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap - <Nop>
let maplocalleader = "-"

nnoremap <Leader><Esc> :noh<CR>
nnoremap <Leader>v viw

" FuzzyFinder
nnoremap <C-p> :FZF<CR>
" fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"

" NERDTree
nnoremap <silent> <C-b> :call ToggleNERD()<CR>

" Open and source init.vim:
:nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <Leader>sv :source $MYVIMRC<cr>

" Echo complete file path:
nnoremap <Leader>n :echo expand('%:p')<CR>

" Open terminal:
nnoremap <C-n> :call OpenTerminal()<CR>
" Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

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
    call Remap('n', '<C-'.t.'>', '<C-w>'.s)
    let index -= 1  
endwhile

" Remap l for custom mappings:
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-l> <C-w>l

" Next and previous tab
nnoremap <A-j> gT
nnoremap <A-l> gt

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

nnoremap <C-f> /
inoremap <C-f> :normal /

set clipboard=unnamed " Use system clipboard
vnoremap <RightMouse> y
nnoremap <RightMouse> p
inoremap <RightMouse> <Esc>:normal p<CR>a

" Always open help in new tab
:cabbrev help tab help
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
set showtabline=2 " Always show tabline

syntax enable
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif
