vim.cmd([[
" Create a submode to handle windows

" The submode is entered whith <Leader>k and exited with <Leader>
call submode#enter_with('WindowsMode', 'n', '', '<Leader>jj', ':echo "windows mode"<CR>')
call submode#leave_with('WindowsMode', 'n', '', '<Leader>')

" Change of windows with hjkl
call submode#map('WindowsMode', 'n', '', 'j', '<C-w>j')
call submode#map('WindowsMode', 'n', '', 'k', '<C-w>k')
call submode#map('WindowsMode', 'n', '', 'h', '<C-w>h')
call submode#map('WindowsMode', 'n', '', 'l', '<C-w>l')

" Resize windows with <C-yuio> (interesting on azerty keyboards)
call submode#map('WindowsMode', 'n', '', 'u', '<C-w>-')
call submode#map('WindowsMode', 'n', '', 'i', '<C-w>+')
call submode#map('WindowsMode', 'n', '', 'y', '<C-w><')
call submode#map('WindowsMode', 'n', '', 'o', '<C-w>>')

" Move windows with <C-hjkl>
call submode#map('WindowsMode', 'n', '', '<C-j>', '<C-w>J')
call submode#map('WindowsMode', 'n', '', '<C-k>', '<C-w>K')
call submode#map('WindowsMode', 'n', '', '<C-h>', '<C-w>H')
call submode#map('WindowsMode', 'n', '', '<C-l>', '<C-w>L')

" close a window with c
call submode#map('WindowsMode', 'n', '', 'c', '<C-w>c')

" split windows with / and !
call submode#map('WindowsMode', 'n', '', '/', '<C-w>s')
call submode#map('WindowsMode', 'n', '', '!', '<C-w>v')

let g:submode_keep_leaving_key = 0
let g:submode_timeout = 0
]])
