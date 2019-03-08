
syntax on
filetype on
filetype plugin on
colorscheme torte

set autochdir
set autowrite
set backupdir=$HOME/.vimbackup/    " but not when they clog .
set copyindent
set directory=$HOME/.vimswap/      " Same for swap files
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set mouse=a
set nocompatible              " be iMproved, required
set number
set smartcase
set smartindent
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set undodir=$HOME/.vimviews/       " same for undo files
set undofile
set undolevels=99999
set undoreload=9999
set viewdir=$HOME/.vimviews/       " same for view files

set softtabstop=4
set expandtab
set shiftwidth=4

silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'

let mapleader = ","

" { go stuff
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>


" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#cmd#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

"  let g:go_fmt_command = "goimports"
"  let g:go_fmt_fail_silently = 0
"  let g:go_highlight_extra_types = 1 
"  let g:go_highlight_fields = 1
"  let g:go_highlight_functions = 1
"  let g:go_highlight_methods = 1
"  let g:go_highlight_operators = 1
"  let g:go_highlight_types = 1
let g:go_metalinter_autosave = 1
"  let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
"  let g:go_metalinter_enabled = ['vet', 'golint']
"  let g:go_snippet_case_type = "snake_case"
" } go stuff

" { yaml stuff
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" }

" { neocomplete stuff
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

let vim_markdown_preview_browser = 'Google Chrome'
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ neocomplete#start_manual_complete()
function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior (not recommended.)
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" :
" \ neocomplete#start_manual_complete()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php =
"\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"let g:neocomplete#sources#omni#input_patterns.c =
"\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
"let g:neocomplete#sources#omni#input_patterns.cpp =
"\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl =
			\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For smart TAB completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ neocomplete#start_manual_complete()
"  function! s:check_back_space() "{{{
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"  endfunction"}}}
"
"
call plug#begin()
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'vim-scripts/SQLUtilities'
Plug 'vim-scripts/ScrollColors'
call plug#end()
