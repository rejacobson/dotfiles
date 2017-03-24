" Beautify JS, CSS, HTML
noremap <leader>a :Autoformat<CR>

" CSS
vnoremap <leader>c :call RangeCSSBeautify()<CR>

" HTML
vnoremap <leader>h :call RangeHtmlBeautify()<CR>

" JS
vnoremap <leader>j :call RangeJsBeautify()<CR>
