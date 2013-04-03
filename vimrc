"
" Jeremy's .vimrc
"

"
" Bundling setup
"

filetype off

call pathogen#incubate()
call pathogen#helptags()

filetype plugin indent on

let g:SuperTabContextTextOmniPrecedence = ['&omnifun', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
	\ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

  autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
    \ endif
"
" General
"

" reload vimrc when it is saved
autocmd! bufwritepost ~/.vimrc source %
autocmd! bufwritepost ~/.vim/vimrc source %
" We're running Vim, not Vi and for a reason!
set nocompatible
" Make backspace sensible
set backspace=indent,eol,start
" Hide the mouse when we begin to type
set mousehide
" Backup files to my home directory
set backupdir=~/.backups
" Write swap files in the same location
set directory=~/.backups
" Ignore quite a file files during wildcard actions
set wildignore=*.swp,*.bak,*.pyc,*.o,*.class
" (% to bounce from do to end, etc.)
runtime! macros/matchit.vim
" always do spell checking
set spell
" disable capitalization check during spell checking
set spellcapcheck=""

"
" Display
"

" Use the solarized color theme
set background=light
colorscheme solarized
" We always want syntax highlighting when it is available
syntax on
" last window will always have a status bar
set laststatus=2
" fancy menu for completion
set wildmenu
" show the matching parens
set showmatch
" blink 5 times for matching paren
set mat=5
" turn on line numbers for easy cursor movement
set number
" Do not add any additional padding to the number list
set numberwidth=1
" draw a vertical bar at column 79
set colorcolumn=79
" always show 2 lines on either side of the cursor
set scrolloff=2
" highlight search matches
set hlsearch
" Show certain invisible characters
set listchars=tab:→\ ,trail:·
set listchars+=extends:>
set listchars+=precedes:<
set list

" Indentation
set noexpandtab                  " do not change tabs to spaces
set tabstop=4
set shiftwidth=4
set shiftround                   " multiple of shiftwidth when < and >'ing
set smarttab
set smartindent

filetype plugin indent on        " filetype-specific indenting and plugins
filetype plugin on

" Operating system specific
if has("gui_macvim")
	set guifont=Inconsolata\ for\ Powerline:h18
	let macvim_hig_shift_movement = 1
endif
if !has("gui_running")
	set spell!
	colorscheme default
endif

runtime! macros/matchit.vim

fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

augroup myfiletypes
	" Clear old autocmds in group
	autocmd!

	" vim should be indented with tabs 4 spaces wide
	autocmd FileType vim setlocal sw=4 ts=4

	" autoindent with 4 spaces, always expand tabs to spaces
	autocmd FileType python setlocal sw=4 ts=4 sts=4 et nowrap

	" autocompletion
	autocmd FileType python set omnifunc=pythoncomplete#Complete

	" Strip trailing whitespaces on several source file types
	autocmd FileType python,html,javascript,tcl
		\ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

	" edifiles
	autocmd BufNewFile,BufRead *.dat,*.edi set ft=edifile

    " rst files
    autocmd BufNewFile,BufRead *.rst set textwidth=78 wrap

	" tcl files
	autocmd FileType tcl set sw=4 ts=4 sts=4 et nowrap nospell
augroup END

"
" Plugin specific settings
"
"let g:flake8_ignore="E501,W293"
"let g:flake8_max_line_length=90
let g:SimpylFold_docstring_preview=1
let g:pyflakes_use_quickfix = 0

" Key mappings

" Change my leader from the default of \ to , which is easier on my hands
let mapleader=","

map <Leader>1 <Plug>TaskList
map <Leader>g :GundoToggle<CR>

" easy mapping to save the file in both normal and insert modes
nno <silent> <C-s> :w<CR>
ino <silent> <C-s> <ESC>:w<CR>a

nnoremap <silent> <Leader>ff :FufCoverageFile<CR>
nnoremap <silent> <Leader>ft :FufTag<CR>
nnoremap <silent> <Leader>fb :FufBuffer<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"nmap <Up> <Nop>
"nmap <Down> <Nop>
"nmap <Left> <Nop>
"nmap <Right> <Nop>

"imap <Up> <Nop>
"imap <Down> <Nop>
"imap <Left> <Nop>
"imap <Right> <Nop>

"vmap <Up> <Nop>
"vmap <Down> <Nop>
"vmap <Left> <Nop>
"vmap <Right> <Nop>

"nnoremap : :<c-u>call SkyBison("")<cr>

" press space to turn off match highlights
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nno <Leader>v :e $MYVIMRC<CR>

nno go o<ESC>k
nno gO O<ESC>j

" center the search match in the center of the screen, forward and backward
nno n nzz
nno N Nzz

nno <Leader>qn :cn<CR>zz
nno <Leader>qf :cnf<CR>zz
nno <Leader>qq :ccl<CR>zz
nno <Leader>qo :copen<CR>zz

nno <Leader>ss :Gstatus<CR>
nno <Leader>sd :Gdiff<CR>
nno <Leader>sb :Gblame<CR>
nno <Leader>sp :Git push<CR>
nno <Leader>sP :Git pull<CR>

" lint checking on python files
nno <Leader>l :call Flake8()<CR>

" Python testing
nno <Leader>tf :Pytest file<CR>
nno <Leader>tc :Pytest class<CR>
nno <Leader>tm :Pytest method<CR>
nno <Leader>tn :Pytest next<CR>
nno <Leader>tp :Pytest previous<CR>
nno <Leader>te :Pytest error<CR>

nno <Leader>bb :CommandTBuffer<CR>
nno <Leader>bf :CommandT<CR>
nno <Leader>bd :bd<CR>

nno <Leader>rg :RopeGotoDefinition<CR>
nno <Leader>rr :RopeRename<CR>

nno <Leader>a <ESC>:Ack!
nno <Leader>n :NERDTreeToggle<CR>

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

