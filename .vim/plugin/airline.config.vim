let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ [ 'z', 'warning' ]
  \ ]
let g:airline_left_sep = ''
let g:airline_right_sep = ''
