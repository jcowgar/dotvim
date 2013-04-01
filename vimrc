"
" Jeremy's .vimrc
"

"
" Bundling setup
"

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Load a few bundles that I like to use
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Command-T'
Bundle 'rstacruz/sparkup'
Bundle 'paradigm/vim-multicursor'
Bundle 'paradigm/SkyBison'
Bundle 'UltiSnips'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'SimpylFold'
Bundle 'vim-flake8'

filetype plugin indent on

"
" General
"

" reload vimrc when it is saved
autocmd! bufwritepost ~/.vimrc source %
autocmd! bufwritepost ~/.vim/vimrc source %
" Change my leader from the default of \ to , which is easier on my hands
let mapleader=","
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
" default includes <Tab> which breaks UltiSnips
let g:ycm_key_list_select_completion = ['<Down>']
" complete words in current buffer, windows, buffers and taglist
set complete=".,w,b,t"

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
set ruler
" turn on line numbers for easy cursor movement
set number
" draw a vertical bar at column 79
set colorcolumn=79               
" always show 2 lines on either side of the cursor
set scrolloff=2                  
" Change the color of the text and background when the text of a line goes
" over 80 characters
"highlight OverLength ctermbg=red ctermfg=white guibg=#ffd9d9
"match OverLength /\%81v.\+/
" highlight search matches
set hlsearch

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
	autocmd FileType vim set sw=4 ts=4

	" autoindent with 4 spaces, always expand tabs to spaces
	autocmd FileType python set sw=4 ts=4 sts=4 et nowrap

	" Strip trailing whitespaces on several source file types
	autocmd FileType python,html,javascript 
		\ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

	" edifiles
	autocmd BufNewFile,BufRead *.dat,*.edi set ft=edifile
augroup END

"
" Plugin specific settings
"
"let g:flake8_ignore="E501,W293"
"let g:flake8_max_line_length=90
let g:SimpylFold_docstring_preview=1

" Key mappings

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

nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>

imap <Up> <Nop>
imap <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>

vmap <Up> <Nop>
vmap <Down> <Nop>
vmap <Left> <Nop>
vmap <Right> <Nop>

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

