"
" Jeremy's .vimrc
"

" General
autocmd! bufwritepost .vimrc source % " reload vimrc when it is saved

set nocompatible                 " we're running Vim, not Vi and for a reason!
set backspace=indent,eol,start
set mousehide
set backupdir=~/.backups
set directory=~/.backups

runtime! macros/matchit.vim      " (% to bounce from do to end, etc.)

" package mananger
execute pathogen#infect()

" Display
set background=light
colorscheme solarized

syntax on
set wildmenu
set showmatch
set mat=5                        " blink 5 times for matching paren
set ruler
set colorcolumn=79               " draw a vertical bar at column 79
set scrolloff=2                  " always show 2 lines on either side of
                                 " the cursor

" Change the color of the text and background when the text of a line goes
" over 80 characters
highlight OverLength ctermbg=red ctermfg=white guibg=#ffd9d9
match OverLength /\%81v.\+/

" Indentation
set noexpandtab                  " do not change tabs to spaces
set tabstop=4
set shiftwidth=4
set smarttab
set smartindent
filetype plugin indent on        " filetype-specific indenting and plugins
filetype plugin on

" Operating system specific
if has("gui_macvim")
	set guifont=Monaco:h14
	let macvim_hig_shift_movement = 1
endif

runtime! macros/matchit.vim

augroup myfiletypes
	" Clear old autocmds in group
	autocmd!
	" autoindent with two spaces, always expand tabs
	autocmd FileType ruby,eruby,yaml,haml set ai sw=2 sts=2 et

	autocmd FileType vim set sw=4 ts=4

	" autoindent with 4 spaces, always expand tabs to spaces
	autocmd FileType python set sw=4 ts=4 sts=4 et
augroup END

