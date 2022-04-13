let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +15 test.js
badd +58 lua/myPlugs/init.lua
badd +1 lua/myPlugs/references.lua
badd +4 lua/myPlugs/syntax-tree-surfer/.git/config
badd +49 lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua
argglobal
%argdel
edit lua/myPlugs/init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
argglobal
balt lua/myPlugs/syntax-tree-surfer/.git/config
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
5,12fold
14,56fold
58,139fold
141,167fold
169,176fold
178,210fold
212,241fold
243,324fold
let &fdl = &fdl
let s:l = 141 - ((140 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 141
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists("~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua") | buffer ~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua | else | edit ~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua
endif
balt ~/.config/nvim/lua/myPlugs/init.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
5,47fold
49,130fold
let &fdl = &fdl
49
normal! zo
let s:l = 104 - ((19 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 104
normal! 0
lcd ~/.config/nvim
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
