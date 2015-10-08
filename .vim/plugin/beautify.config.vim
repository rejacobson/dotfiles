" Beautify JS, CSS, HTML
vnoremap <F2> :Autoformat<CR>
vnoremap <buffer> <F3> :call RangeCSSBeautify()<CR>
vnoremap <buffer> <F4> :call RangeHtmlBeautify()<CR>
vnoremap <buffer> <F5> :call RangeJsBeautify()<CR>
