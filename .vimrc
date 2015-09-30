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
if exists("&re")
  set re=1
endif
syntax on       " Turn on syntax highlighting
set background=dark
colorscheme dark-ruby

" NERDTree
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :NERDTree<CR>
let NERDTreeMapActivateNode='<space>'

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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Tabs and spaces
set tabstop=2
set shiftwidth=2
set expandtab

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

let g:EasyMotion_leader_key = '<Space>'
let mapleader=","

""""""""""""""""""""""""
" Beautify JS, CSS, HTML
""""""""""""""""""""""""
" Beautify the whole file
noremap <c-s-c> :call CSSBeautify()<cr>
noremap <c-s-h> :call HtmlBeautify()<cr>
noremap <c-s-j> :call JsBeautify()<cr>

" Beautify only the selected text
vnoremap <c-s-c> :call RangeCSSBeautify()<cr>
vnoremap <c-s-h> :call RangeHtmlBeautify()<cr>
vnoremap <c-s-j> :call RangeJsBeautify()<cr>

set encoding=utf-8
set fileencoding=utf-8

" ctrl-p ignores these directories
let g:ctrlp_custom_ignore = 'coverage/'

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
