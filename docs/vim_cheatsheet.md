---
"layout": "article",
"title": "vim_cheatsheet",
"date": "2020-11-05",
"description": "My personal cheatsheet for my (n)vim setup",
"tags": ["vim", "nvim", "cheatsheet"]
---

| (n)vim Cheatsheet | [back](./index.html) |
| :-- | :-- |
| <h3>Cursor movement</h3> | |
Cursor movement { left, down, up, right } |  ~~h~~, ~~j~~, ~~k~~, l &rarr; j, k, i, l
Move to { top, mid, bottom } of screen | ~~`H`~~ &rarr; `J`, `M`, `L`
Jump forwards to { start, end } of a word + ignoring punctuation | `w`, `e` + `W`, `E`
Jump backwards to start of a word + ignoring punctuation | `b`, `B`
Jump to { start, end } of line | `0`, `$`
Jump to { first, last } non blank character | `^`, `g_`
Go to matching character (supported are **()**, **{}**, **[]**; check :h matchpairs) | `%`
Go to { first, last } line of code | `gg`, `G`
Go to **n**-th line | **n**`gg` or **n**`G`
Jump to { next, previous } occurence of character **x** | `f`**x**, `F`**x**
Jump to { before next, after previous } occurence of character **x** | **t`x`, F`x`**
Repeat previous **f, t, F, T** command { forwards, backwards } | `;`, `,`
Jump to { previous, next } function/block | `{`, `}`
Center cursor on screen | `zz`
Move cursor { up, down } one line | `<C-y>`, `<C-e>`
Move { forward, back } one full screen | ~~`<C-f>`~~, ~~`<C-b>`~~ *
Move { forward, back } one half screen | `<C-d>`, `<C-u>`
Set current cursor position as position **n** | `m`**n**
Jump to position **n** | <code>\`</code>**n** &rarr; `,`**n**
Jump to position before jump | <code>\`\`</code> &rarr; `,,`
Go to latest change in file | <code>\`.</code> &rarr; `,.`
| <h3>Editing</h3> | |
Replace single character | **r**
Join line below with current line { with, without } space | `J`, `gJ`
{ Lower-, Upper-, switch } case up to next movement | `g~`, `gu`, `gU`
Replace { entire, up to end of } line | `cc` or `S`, `C` or `c$`
Replace { enire, up to end of } word | `ciw`, `cw`
Shift text { left, right } | `<<`, `>>`
{ Copy, Delete } **n** lines (default is 0) | **n**`yy`, **n**`dd`
{ Copy, Delete } to end of + { word, line } | `yw`, `dw`, `y$`, `d$` or `D`
Delete character | `x`
Paste { before, after } cursor | `p`, `P`
Reindent buffer (see honorable mentions why this works) | `gg=G`
{ Undo, Restore last changed line, Redo } | `u`, `U`, `<C-r>`
Repeat last command | `.`
| <h3>Insert mode</h3> |  |
Enter insert mode { before, after } cursor | ~~`i`~~ &rarr; `h`, `a`
Enter insert mode at the { beginning, end } of the line | ~~`I`~~ &rarr; `H`, `A`
Open a new line { below, above } the current line and enter insert mode | `o`, `O`
Append at end of word and enter insert mode | `ea`
Delete { character, word } before cursor (during insert mode) | `<C-h>`, `<C-w>`
New line (during insert mode) | `<C-j>`
{ Indent, Deindet } (during insert mode) | `<C-t>`, `<C-d>`
Insert { previous, next } best guess (auto-complete) (during insert mode) | `<C-p>`, `<C-n>`
~~Insert content of register **x**~~ ** | ~~`<C-r>`**x**~~ **
| <h3>Visual mode</h3> |  |
Start visual mode { normal, linewise, blockmode } | `v`, `V`, `<C-v>`
Move between { start or end, corners } of selection | `o`, `O`
Mark a word | `aw`
Mark between { **()**, **{}**, **<>** } + in { inner ,outer } block | `ib`, `iB`, `it`, `ab`, `aB`, `at`
{ Lower, upper, switch } case for marked text | `u`, `U`, `~`
Shift marked text { left, right } | `<`, `>`
{ Copy (yank), Delete (cut) } marked text | `y`, `d`
| <h3>Layout</h3> | |
Move split into own tab | `<C-w>T`
Move to { previous, next } tab | `gT` &rarr; `<C-j>`, `gt` &rarr; `<C-l>`
Move to tab number **n** | **n**`gt` or `<A-`**n**`>`
Split window {, vertically} | `<C-w>s`, `<C-w>v`
Switch windows {, with next one } | `<C-w>w`, `<C-w>x`
Quit window | `<C-w>q`
Move cursor to window { left, down, up, right } | ~~`<C-w>h`~~, ~~`<C-w>j`~~, ~~`<C-w>k`~~, ~~`<C-w>l`~~ &rarr; `<C-w>j`, `<C-w>k`, `<C-w>i`, `<C-w>l`
| <h3>Commands | |
{Write (W), Quit (Q), Force (F) Q, W & Q, Q all (a), F Q a, W & Q a} | `:w`, `:q`, `:q!`, `:wq`, `:qa`, `:qa!`, `:wqa`
Edit in new buffer | `:e`
Go to { next, previous } buffer | `:bn`, `:bp`
Go to buffer **n** (number of filename) | `:b`**n**
List buffers | ':ls' or ':buffers'
Delete buffer | `:bd`
Search { forwards, backwards } **abc** | `/`**abc** or `<C-f>`**abc**, `?`**abc**
Repeat search in { same, opposite } direction | `n`, `N`
Replace all **abc** with **def** in buffer + confirmation | `:%s/`**abc**`/`**def**`/g`, `.../`**def**`/gc`
Open file in new buffer and split window {, vertically} | `:sp`, `:vs`
Open all buffers as { vertical windows, tabs } | `:vert`, `:tab ba`
| <h3>Honorable mentions</h3> |  |
Indent a block with **()** or **{}** (cursor on brace) | `>%`
{Re-}Indent block with + { **()**, **{}**, **<>** } | `=ib`, `=iB`, `=at` + `>ib`, `>iB`, `>at`
Paste and adjust indent in current line | `]p`
Reindent **n** lines | **n**==
~~{ Copy, paste } into register **n** (x for system clipboard)~~** | `ny`, `np`
{ Record, Run } macro **n** | `q`**n**, `@`**n**
Stop recording | `q`
Rerun last macro | `@@`
Go to position { where vim was exited, when last editing file, of last change } | <code>\`0</code>, <code>\`"</code>
Go to { newer, older } position in + { jump, change} list | `<C-i>`, `<C-o>`, `g,`, `g;`
Jump to tag under cursor | `<C-]>`
Search **abc** using regex magic | `\v`**abc**
| <h3>Custom</h3> |  |
| Toggle *NERDTree* | `<C-b>`
| **:noh** (Remove hightlights; e.g. from search) | `<Leader><Esc>`
| Open FuzzyFinder | `<C-p>`
| <h3>NERDTree</h3> |  |
Open file in { prev window, split, vsplit, new tab + silent } | `<cr>` or `o`, `i`, `s`, `t` + `T`
Open file in preview { prev window, split, vsplit } | `go`, `gi`, `gs`
{Recursevly Open, Open or Close, explore} directory | `O`, `o`, `e`
Close {parent, all children recursively} | `x`, `X`
Change tree root to directory | `C`
Move tree root up a dir {, but leave old root open} | `u`, `U`
Refresh {selected dir, current root} | `r`, `R`
Show menu | `m`
Change **CWD** to { selected dir, tree root } | `cd`, `CD`
Go to { parent, root}  | `p`, `P`
Go to {first, last} child | ~~`K`~~, ~~`J`~~ &rarr; `I`, `K`
Go to {previous, next} sibling | ~~`<C-k>`~~, ~~`<C-J>`~~ &rarr; `<C-i>`, `<C-k>`
Toggle { hidden files, file filters, files, bookmarks, maximize, help } | ~~`I`~~ &rarr; `H`, `f`, `F`, `B`, `A`, `?`

<p>* See custom commands <br>
** Registers are set to system registers (set clipboard = unnamed)</p>
