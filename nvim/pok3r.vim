fu Remap(type, lhs, rhs)
    exe a:type.'noremap' a:lhs a:rhs
endfu

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

