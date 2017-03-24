" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

inoremap kj <Esc>

" Remove trailing spaces
map <Leader><space> :%s/\s\+$//g<CR>

" Press Leader Space to turn off highlighting and clear any message already displayed.
map <Leader>n :noh<CR>

" Prevent pasting into a selection from overwriting the contents of the register
" pgvy ==  'p' paste, 'gv' re-select what was originally selected, 'y' to copy it again
xnoremap p pgvy

" resize splits quickly
map = <c-w>+
map - <c-w>-
map + <c-w>>
map _ <c-w><
