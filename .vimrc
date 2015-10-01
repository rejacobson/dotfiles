" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" Vundle package manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
source ~/.vim/.plugins
call vundle#end()
filetype plugin indent on

" Set the status bar and show the current git branch
set statusline=%f\ L\ %l,C\ %c\ (%p%%)\ %m\ %{fugitive#statusline()}

" General Options
set number      " Show line numbers on the side
set hlsearch    " Highlight all search pattern matches
set showcmd     " Display info about the current command
set showmode    " Indicates input or replace mode at bottom
set incsearch   " Show matches as you type a search term
set paste       " Retain tab and space indenting of pasted code
set hidden      " Hide buffers instead of closing them.
set so=14
set splitbelow
set splitright
set encoding=utf-8
set fileencoding=utf-8

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Tabs and spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Color scheme
if exists("&re")
  set re=1
endif
syntax on       " Turn on syntax highlighting
set background=dark
colorscheme dark-ruby

let g:EasyMotion_leader_key = '<Space>'
let mapleader=","

" ctrl-p ignores these directories
let g:ctrlp_custom_ignore = 'coverage/'

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Remove trailing spaces
map <Leader><space> :%s/\s\+$//g<CR>

" Press Leader Space to turn off highlighting and clear any message already displayed.
map <Leader>n :noh<CR>

" Prevent pasting into a selection from overwriting the contents of the register
" pgvy ==  'p' paste, 'gv' re-select what was originally selected, 'y' to copy it again
xnoremap p pgvy

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

""""""""""""""""""""""""
" Beautify JS, CSS, HTML
""""""""""""""""""""""""
vnoremap <F2> :Autoformat<CR>
vnoremap <buffer> <F3> :call RangeCssBeautify()<CR>
vnoremap <buffer> <F4> :call RangeHtmlBeautify()<CR>
vnoremap <buffer> <F5> :call RangeJsBeautify()<CR>

" rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

function! RunCurrentSpecFile()
  if InSpecFile()
    let l:command = "zspec '" . @% . " -f documentation'"
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunNearestSpec()
  if InSpecFile()
    let l:command = "zspec '" . @% . ":" . line(".") . " -f documentation'"
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunLastSpec()
  if exists("t:last_spec_command")
    call RunSpecs(t:last_spec_command)
  endif
endfunction

function! InSpecFile()
  return match(expand("%"), "_spec.rb$") != -1
endfunction

function! SetLastSpecCommand(command)
  let t:last_spec_command = a:command
endfunction

function! RunSpecs(command)
  execute ":w\|!clear && echo " . a:command . " && echo && " . a:command
endfunction

au BufNewFile,BufRead *.mab set filetype=ruby
