"" Vundle {{{

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tikhomirov/vim-glsl'
Plugin 'embear/vim-localvimrc'
call vundle#end()
let g:indent_guides_enable_on_vim_startup=1
let g:syntastic_check_on_open=1

" Enable plugins and indenting rules to vary by filetype
filetype plugin indent on

" }}}

"" Leader {{{

let mapleader=","

" }}}

"" Colors {{{

" Set the number of colors in the terminal
set t_Co=256

" Load the colorscheme
colorscheme desert

" Set the brightness of the background color (light/dark)
set background=dark

" }}}

"" UI Config {{{

" Display line numbers
set number

" Show the last command entered in the bottom right
set showcmd

" Highlight the current line
set cursorline

" Highlight a column in the editor
set colorcolumn=120

" Show the line and column number of the current position
set ruler

" Turn on syntax highlighting
syntax on

" Visual autocomplete for vim command line
set wildmenu

" Only redraw when necessary
set lazyredraw

" Indicates a fast terminal connection
set ttyfast

" Show matching ({[]})
set showmatch

" Display current vim mode (insert, replace, visual)
set showmode

" Forces the window to always have a status line
set laststatus=2

" Set the C-style indentation rules (see :help cinoptions-values)
set cinoptions=:0,g0,N-s

" Be able to backspace over indents, end of lines, and start of lines
set backspace=indent,eol,start

" Enable all mouse functionality
set mouse=a

" }}}

"" Spaces, Tabs, and Indents. Oh my! {{{

" Number of visual spaces per tab
set tabstop=4

" Number of spaces in a tab when editing
set softtabstop=4

" Number of spaces in a tab when moving
set shiftwidth=4

" Copy indent from current line when starting a new one
set autoindent

" }}}

"" Searching {{{

" Highlight all search results
set hlsearch

" Incrementally search while you type
set incsearch

" Ignore case while searching
set ignorecase

" Search by case if you use capitals
set smartcase

" Automatically search without vim's regex
nnoremap / /\v
vnoremap / /\v

" Turn off search highlights with ,<space>
nnoremap <leader><space> :nohlsearch<CR>

" }}}

"" Movement {{{

" Move up/down to the next visual line rather than wrapped line
nnoremap j gj
nnoremap k gk

"" Folding

" Enable folding of scopes
set foldenable

" Fold on indentation
set foldmethod=indent

" Set the number of fold levels to have open on start
set foldlevelstart=10

" Set max number of folds
set foldnestmax=10

" Open/close folds with <space>
nnoremap <space> za

" }}}

"" Misc {{{

" Enable per-direction vimrc files (.lvimrc)
set exrc

" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Don't autocomplete to specific filetypes
set wildignore+=*.git,*.svn,*.o,*.lib
if has('unix')
    set wildignore+=*.a,*.dylib,*.dSYM,*.DS_Store
elseif has('win32') || has('win64')
    set wildignore+=*.dll
endif

" }}}

"" Org {{{

set modelines=1

" }}}

" vim:foldmethod=marker:foldlevel=0
