set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_eruby_ruby_quiet_messages = {'regex': 'in void context'}
let g:syntastic_quiet_messages = {'regex': 'Undefined mixin\|failed to @extend\|Undefined variable\|File to import not found'}
