nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap - <Nop>
" let maplocalleader = "-"
nnoremap - /

nnoremap ' :find
nnoremap <Leader><Esc> :noh<CR>

" https://stackoverflow.com/questions/3878692/how-to-create-an-alias-for-a-command-in-vim
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("ev","vsplit $MYVIMRC")
call SetupCommandAlias("src","source $MYVIMRC")

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

" Open file of path under cursor in new tab
nnoremap <C-g> <C-w>gf
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

vnoremap <RightMouse> "*y
nnoremap <RightMouse> "*p<CR>
inoremap <RightMouse> <Esc>"*pa

