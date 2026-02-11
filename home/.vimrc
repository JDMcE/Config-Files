set nocompatible              " be iMproved, required
set number		      " set line numbers
set relativenumber
syntax on                     " syntax highlighting 
set belloff=all               " no beeping or flashing
set tabstop=4
set shiftwidth=4

" Search improvements
set incsearch               " Incremental search as you type
set hlsearch                " Highlight search results
set ignorecase              " Case insensitive search
set smartcase               " Case sensitive if search contains uppercase
set magic                   " for regex

" Display improvements
set showcmd                 " Show command in bottom bar
set showmatch               " Highlight matching brackets
set wildmenu                " Visual autocomplete for command menu
set ruler                   " Show cursor position
set cmdheight=1             " command line size

" Indentation & formatting
set autoindent              " Auto-indent new lines
set smartindent             " Smart indentation
set expandtab               " Use spaces instead of tabs
filetype plugin indent on   " Enable filetype-specific indentation

" Editing improvements
set backspace=indent,eol,start  " Make backspace work as expected
set mouse=a                 " Enable mouse support
set clipboard=unnamedplus   " Use system clipboard (Linux)
" set clipboard=unnamed     " Alternative for some systems

" Performance & UX
set ttyfast
set autoread
set undofile
set undodir=~/.vim/undodir

set completeopt=menuone,longest,preview

" Scroll offset
set scrolloff=8
set sidescrolloff=8

let mapleader=","


" Key Mappings
" Clear search highlighting with ESC
nnoremap <esc> :noh<return><esc>

" Quick save
nnoremap <leader>w :w<CR>
" sudo save
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
