" This must be first, because it changes other options as a side effect.
let mapleader=","

" Use Vim settings, rather than Vi settings (much better!).
set nocompatible

" Vundle package manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
source ~/.vim/vundle.plugins
call vundle#end()
filetype plugin indent on

" format the status bar
set statusline=%f\ L\ %l,C\ %c\ (%p%%)\ %m

" Show line numbers on the side
set number

" Highlight all search pattern matches
set hlsearch

" Display info about the current command
set showcmd

" Indicates input or replace mode at bottom
set showmode

" Show matches as you type a search term
set incsearch

" nopaste because otherwise it doesn't allow for key bindings using imap
set nopaste

" Hide buffers instead of closing them.
set hidden

" scrolloff - sets number of lines that are visible below and above the cursor
set so=10

" set the position of new windows
set splitbelow
set splitright

" file encoding
set encoding=utf-8
set fileencoding=utf-8

" Always show the status line
set laststatus=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" how many columns a tab counts for
set tabstop=2

" how many columns text is indented with the reindent operations
set shiftwidth=2

" turn tabs into spaces
set expandtab

" force the old regexp engine. I had issues with performance using the newer
" regexp version
if exists("&re")
  set re=1
endif

" use 256 colors
set t_Co=256

" use a dark background
set background=dark

"colorscheme kolor
colorscheme Tomorrow-Night

" Turn on syntax highlighting
syntax on

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" markaby files should be highlighted as ruby code
au BufNewFile,BufRead *.mab set filetype=ruby
