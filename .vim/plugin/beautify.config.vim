" Beautify JS, CSS, HTML
noremap <leader>ba :Autoformat<CR>

" CSS
vnoremap <leader>bc :call RangeCSSBeautify()<CR>

" HTML
vnoremap <leader>bh :call RangeHtmlBeautify()<CR>

" JS
vnoremap <leader>bj :call RangeJsBeautify()<CR>
