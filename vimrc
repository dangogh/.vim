set nocompatible
set autochdir
set autoindent
set backup
set writebackup
" set autowriteall
set backspace=indent,eol,start
set expandtab
set hlsearch
set incsearch
set smartcase
set ignorecase
set laststatus=2
set lazyredraw
" set makeprg=...
set mousehide
set number
set ruler
set showcmd
set showmode
set sidescroll=1
set wrapmargin=1
set smarttab
set suffixes=.bak,.swp,.bak,~,.o
set wildchar=<TAB>

""""""""""""""""""""""""""""""""""""""""
" Set up vundle
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Plugin 'Blackrush/vim-gocode'
"Plugin 'majutsushi/tagbar'
"Plugin 'altercation/vim-colors-solarized'

" Github repos of the user 'vim-scripts'
" => can omit the username part
"Plugin 'L9'
"Plugin 'FuzzyFinder'
Plugin 'genutils'
Plugin 'perforce'
" enhanced autocomplete
Plugin 'VimCompletesMe'

" non github repos
"Plugin 'git://git.wincent.com/command-t.git'
" ...


set history=50		" keep 50 lines of command line history

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
let &guioptions = substitute(&guioptions, "t", "", "g")

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Vim plugins for Go (http://golang.org)
" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" go fmt before saving
autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd FileType go compiler go

set background=dark
colorscheme torte
