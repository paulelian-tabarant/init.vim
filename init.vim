source ~/.config/nvim/plugins.vim

" Global variables
" =
set encoding=utf-8
" Theme definition
colorscheme kanagawa
set background=dark
set termguicolors
" Airline theme definition
let g:airline_theme='minimalist'
" Disable compatibility with vi, which can cause unexpected issues.
set nocompatible
" Set tab width
set tabstop=2
" The same but for indents
set shiftwidth=2
" Keep cursor in approximately the middle of the screen
set scrolloff=12
" Do not save backup files.
set nobackup
set nowritebackup
" Do not wrap lines when overflowing the screen width
set nowrap
" Converts tabs to spaces
set expandtab
" Disable mouse support
set mouse=
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
" Enable plugins and load plugin for the detected file type.
filetype plugin on
" Load an indent file for the detected file type.
filetype indent on
" Turn syntax highlighting on.
syntax on
" File explorer
if empty(argv())
  au VimEnter * NERDTree
endif

" Writing
autocmd FileType markdown runtime ~/.config/nvim/writing/*.vim

" Development
runtime ~/.config/nvim/development/*.vim
