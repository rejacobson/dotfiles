" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Pathogen - vim package manager
call pathogen#infect() 

" Set the status bar and show the current git branch
set statusline=%f\ L\ %l,C\ %c\ (%p%%)\ %m\ [%{GitBranch()}]

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Color scheme
colorscheme dark-ruby

" NERDTree
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :NERDTree<CR>
let NERDTreeMapActivateNode='<space>'

" General Options
syntax on       " Turn on syntax highlighting
set number      " Show line numbers on the side
set hlsearch    " Highlight all search pattern matches
set showcmd     " Display info about the current command
set showmode    " Indicates input or replace mode at bottom
set incsearch   " Show matches as you type a search term
set paste       " Retain tab and space indenting of pasted code
set hidden      " Hide buffers instead of closing them.

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Tabs and spaces
set tabstop=2
set shiftwidth=2
set expandtab
