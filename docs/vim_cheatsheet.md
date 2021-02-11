---
"layout": "article",
"title": "vim_cheatsheet",
"date": "2020-11-05",
"description": "My personal cheatsheet for my (n)vim setup",
"tags": ["vim", "nvim", "cheatsheet"]
---

## nvim cheatsheet

Commands are generally composed of:
`verb[specifier][word]`

Not everything is straight forwards. Be creative with my interpretation.

`dhw` = delete inner word where the cursor is right now.

Verbs describe what shall be done. They need a **noun** to work.

| <h2>verbs</h2> |                                  |
| :------------- | -------------------------------: |
| d              |                           delete |
| c              | change (delete and enter insert) |
| r              |                          replace |
| p, P           |     paste {before, after} cursor |
| u              |                             undo |
| \<C-r\>        |                             redo |
| \>             |                           indent |
| v              |                  visually select |
| y              |                      yank (copy) |
| gc             |    comment (from vim-commentary) |

| <h2>nouns</h2> |                               |
| :------------- | ----------------------------: |
| d              |                        delete |
| w              | word (forward to end of word) |
| "              |                             " |
| t              |                   tags (html) |
| b              |                      brackets |
| p              |                     paragraph |
| \> , <         |            {indent, deindent} |
| as             | as sentence (untested now...) |
| m**x**         |                set mark **x** |

Specifiers without a verb are used for movement.

| <h2>specifier</h2>      |                                                              |
| :---------------------- | -----------------------------------------------------------: |
| **n**                   | **n** is a number and can prepend a specifier to multiply it |
| ~~h,j,k,l~~ &rarr; jkil |                                 Move {left, down, up, right} |
| ~~H~~ &rarr; J, M, L    |                         Move to {top, mid, bottom} of screen |
| b                       |     back (back by a word, Capitalize to include punctuation) |
| e, w                    |             to next word (Capitalize to include punctuation) |
| {, }                    |                           to {previous, next} function block |
| gg, G                   |                                  to {start, end} of document |
| ~~i~~ -> h              |                       inner (e.g. dhw for delete inner word) |
| a                       |                       outer (e.g. daw for delete outer word) |
| f**x**                  |      up to next x (e.g. cfu for cut to next character **u**) |
| F**x**                  |                                                 up to last x |
| t**x*, T*x**            |                        same as f, F, but not including **x** |
| \`**x**                 |                                             up to mark **x** |
| s                       |                                                   surround\* |
| n, N                    |          up to {next, last} occurence (of search using **/** |
| "**x**                  |              Copy and Pastes in and from register **x**.\*\* |

\* from surround-vim, e.g. cs"' => change surrounding " to '. or: yshw" => surround inner word with "<br>
\*\* {\*} is the system clipboard. "\*yy will yank the current line into the system clipboard, "\*p will paste the system clipboard.

| <h2>modes</h2>    |                                                                                                                     |
| :---------------- | ------------------------------------------------------------------------------------------------------------------: |
| ~~i~~ &rarr; h, a |                                                                            enter insert mode {before, after} cursor |
| ~~I~~ &rarr; H, A |                                                                                enter insert at {start, end} of line |
| \<C-h\>, \<C-w\>  |                                                             delete { character, word } before cursor in insert mode |
| \<C-j\>           |                                                                                             new line in insert mode |
| \<C-t\>, \<C-d\>  |                                                                                   {indent, deindent} in insert mode |
| \<C-n\>, \<C-p\>  |                                              navigate through auto-completion in insert mode (is this through coc?) |
| \<C-r\>**x**      |                                                                        insert content of register **x** (test this) |
| Remember:         | If you have to use visual mode you are most likely missing out on some stuff. Visual mode does not allow repeating. |
| v                 |                                                                                                   enter visual mode |
| o, O              |                                                                              move between {start, end} of selection |
| aw                |                                                                                                         mark a word |

These are somehow special and I could not put them into the other tables.
Most of them can be prepended by the **n** specifier where it makes sense.
| <h2>other</h2> ||
| :-- | --: |
o, O | Insert line {under, above} current line (enter insert mode)
x | delete character
. | repeat last change
/ | search forward
? | search backwards
,, | jump back
,. | go to latest change in file
\<C-w\>T | Move split into own tab
\<A-**n**\> | Go to tab **n**
:ls | List buffers
:b **n** | Go to buffer **n**
:sp, :hs | Split {vertically, horizontally}
zz | center cursor on screen
\<C-d\>, \<C-u\> | Move screen {down, up} half screen
:**n**s/**abc**/**def** | Replace **n** (**%** for all) occurences of **abc** with **def**
:**n**s/**abc**/**def**/gc | Same but with confirmation

<h2>Useful stuff</h2>

|                 | <div style="width:200px"><div>        |                                                                                                                     |
| :-------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------: |
| Snippet command | **x** :-1read **path**\<CR\>**move**a |                        use command **x** to read file at **path**,**move** where you wanna be and enter insert mode |
| Remove buffers  | :bd **x** \<C-a\>                     | Remove all buffers that match **x**. E.g. :bd **node_modules** \<C-a\> to close all buffers open from node_modules. |

| <h2>removed</h2> |                                    |
| :--------------- | ---------------------------------: |
| \<C-f\>, \<C-b\> | Move screen {down, up} half screen |
