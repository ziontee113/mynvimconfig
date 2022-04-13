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
badd +5 lua/myPlugs/init.lua
badd +20 init.lua
badd +283 lua/user/mappings.lua
badd +132 lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua
argglobal
%argdel
edit lua/user/mappings.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
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
exe '2resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
exe '3resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 105 + 105) / 211)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 283 - ((44 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 283
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists("~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua") | buffer ~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua | else | edit ~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua
endif
balt ~/.config/nvim/init.lua
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
132,139fold
143,165fold
167,172fold
174,206fold
let &fdl = &fdl
let s:l = 132 - ((131 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 132
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists("~/.config/nvim/lua/myPlugs/init.lua") | buffer ~/.config/nvim/lua/myPlugs/init.lua | else | edit ~/.config/nvim/lua/myPlugs/init.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/myPlugs/init.lua
endif
balt ~/.config/nvim/lua/myPlugs/syntax-tree-surfer/lua/syntax-tree-surfer/init.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
12,12fold
14,56fold
58,139fold
141,163fold
165,170fold
172,204fold
206,235fold
237,318fold
let &fdl = &fdl
12
normal! zo
237
normal! zo
let s:l = 4 - ((3 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 4
normal! 0
lcd ~/.config/nvim
wincmd w
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe '2resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
exe '3resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 105 + 105) / 211)
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
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
