set autochdir
set backup
set writebackup
" set autowriteall
set backspace=indent,eol,start
"set expandtab
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
"set smarttab
set suffixes=.bak,.swp,.bak,~,.o
set wildchar=<TAB>

""""""""""""""""""""""""""""""""""""""""
" VUNDLE {
" git clone git@github.com:gmarik/Vundle.vim ~/.vim/bundle/Vundle
" :PluginInstall
set nocompatible
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle/
call vundle#begin()
" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle'

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
"Plugin 'genutils'
Plugin 'VimCompletesMe'
Plugin 'git://github.com/rdunklau/vim-perltidy.git'
Plugin 'git://github.com/vim-scripts/perlprove.vim.git'
Plugin 'git://github.com/srooloose/nerdtree.git'
Plugin 'git://github.com/scrooloose/nerdcommenter.git'

" non github repos
"Plugin 'git://git.wincent.com/command-t.git'
" ...
" { vundle from dew
"Plugin 'git://github.com/rstacruz/sparkup'
"
"" vim-scripts repos
"Plugin 'https://github.com/dewrich/unite.vim.git'
"Plugin 'https://github.com/dewrich/neomru.vim'
"Plugin 'git://github.com/dewrich/L9.git'
"Plugin 'git://github.com/dewrich/ack.vim.git'
"Plugin 'git://github.com/dewrich/indentpython.vim.git'
""Plugin 'git://github.com/dewrich/snipmate.vim.git'
"Plugin 'git://github.com/dewrich/supertab.git'
"Plugin 'git://github.com/dewrich/syntastic.git'
"Plugin 'git://github.com/dewrich/tlib_vim.git'
"Plugin 'git://github.com/dewrich/vim-fugitive.git'
""Plugin 'git://github.com/dewrich/vimfiles.git'
"Plugin 'git://github.com/dewrich/socketIO-client.git'
"Plugin 'https://github.com/dewrich/mru.vim.git'
"Plugin 'git://github.com/benmills/vimux.git'
"Plugin 'git://github.com/fatih/vim-go.git'
"Plugin 'git://github.com/Valloric/YouCompleteMe.git'
"Plugin 'git://github.com/golang/lint.git'
""Plugin 'git://github.com/Lokaltog/powerline.git'
"Plugin 'git://github.com/bling/vim-airline.git'
"Plugin 'git://github.com/SirVer/ultisnips.git'
"Plugin 'git://github.com/dewrich/vim-easygrep.git'
"Plugin 'git://github.com/honza/vim-snippets.git'
"Plugin 'git://github.com/tpope/vim-rbenv.git'
"Plugin 'git://github.com/michalliu/sourcebeautify.vim.git'
""Plugin 'git://github.com/Yggdroot/indentLine'
""Plugin 'git://github.com/kien/ctrlp.vim.git'
"Plugin 'git://github.com/vim-scripts/ScrollColors.git'
"Plugin 'git://github.com/Rykka/InstantRst.git'
"Plugin 'git://github.com/Rykka/riv.vim.git'
"Plugin 'git://github.com/Rykka/rhythm.css.git'
"Plugin 'git://github.com/airblade/vim-gitgutter.git'
"Plugin 'git://github.com/tpope/vim-surround.git'
"Plugin 'git://github.com/tpope/vim-repeat.git'
"Plugin 'git://github.com/bronson/vim-visual-star-search.git'
"Plugin 'mattn/webapi-vim'
"Plugin 'cirla/vim-giphy'
""Plugin 'git://github.com/Raimondi/delimitMate.git'
"Plugin 'git://github.com/jiangmiao/auto-pairs.git'
"Plugin 'git://github.com/nelstrom/vim-qargs.git'
""Plugin 'git://github.com/davidpthomas/vim4rally.git'
"Plugin 'git://github.com/vim-ruby/vim-ruby.git'
"Plugin 'git://github.com/vim-scripts/MultipleSearch.git'

    call vundle#end()
" } vundle from dew
" } VUNDLE


set history=5000

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
let &guioptions = substitute(&guioptions, "t", "", "g")

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  " make y/p work from iterm selection
  set clipboard=unnamed
endif

" Setting up the directories {
  set undofile                       " so is persistent undo ...
  set copyindent                  " (ci) when auto-indenting, use the indenting format of the previous line
  set undolevels=1000                " maximum number of changes that can be undone
  set undoreload=10000               " maximum number lines to save for undo on a buffer reload
  set backup
  set backupdir=$HOME/.vimbackup/    " but not when they clog .
  set directory=$HOME/.vimswap/      " Same for swap files
  set viewdir=$HOME/.vimviews/       " same for view files
  set undodir=$HOME/.vimviews/       " same for view files
  "" Creating directories if they don't exist
  silent execute '!mkdir -p $HOME/.vimbackup'
  silent execute '!mkdir -p $HOME/.vimswap'
  silent execute '!mkdir -p $HOME/.vimviews'
  "au BufWinLeave * silent! mkview    " make vim save view (state) (folds, cursor, etc)
  "au BufWinEnter * silent! loadview  " make vim load view (state) (folds, cursor, etc)
" }


" {
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
" }

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

" Vim UI {
  " Favorite color schemes
  "set showbreak=->                    " a marker to highlight wrapped lines
  set tabstop=4                        " tabstops
  set shiftwidth=2                     " shift width
  "set expandtab                        " turn ^T to spaces
  set tabpagemax=15                    " only show 15 tabs
  set showmode                         " display the current mode
  set cursorline                       " highlight current line
  hi cursorline guibg=#333333          " highlight bg color of current line
  "set cursorcolumn                       " highlight current column
  hi CursorColumn cterm=NONE ctermbg=236 ctermfg=NONE guibg=lightblue ctermbg=lightgray 
  hi CursorLine   cterm=NONE ctermbg=236 ctermfg=NONE gui=NONE guibg=#2d2d2d guifg=NONE
" only  turn on for current split window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

  if has('cmdline_info')
    set ruler                          " show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd                        " show partial commands in status line and
                                       " selected characters/lines in visual mode
  endif

  set linespace=0                 " No extra spaces between rows
  "set nu                          " Line numbers on
  set showmatch                   " show matching brackets/parenthesis
  set incsearch                   " find as you type search
  set hlsearch                    " highlight search terms
  set winminheight=0              " windows can be 0 line high 
  set ignorecase                  " case insensitive search
  set smartcase                   " case sensitive when uc present
  set wildmenu                    " show list instead of just completing
  set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
  "set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
  set scrolljump=5                " lines to scroll when cursor leaves screen
  "set scrolloff=3                 " minimum lines to keep above and below cursor
  set nofoldenable                 " turn off autofolding
  "set gdefault                    " the /g flag on :s substitutions by default
  "set list
   "set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
" }
