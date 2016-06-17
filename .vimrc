" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
let mapleader=","

set nocompatible
filetype off

" Vundle package manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
source ~/.vim/vundle.plugins
call vundle#end()
filetype plugin indent on

" Set the status bar
set statusline=%f\ L\ %l,C\ %c\ (%p%%)\ %m

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" General options
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
set laststatus=2 " Always show the status line

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
set t_Co=256
set background=dark
colorscheme kolor

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

au BufNewFile,BufRead *.mab set filetype=ruby


" Remove trailing spaces
map <Leader><space> :%s/\s\+$//g<CR>

" Press Leader Space to turn off highlighting and clear any message already displayed.
map <Leader>n :noh<CR>

" Prevent pasting into a selection from overwriting the contents of the register
" pgvy ==  'p' paste, 'gv' re-select what was originally selected, 'y' to copy it again
xnoremap p pgvy
