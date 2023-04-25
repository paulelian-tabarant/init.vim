" Custom <leader> key
let mapleader = ","
" Enable line numbering for Web development
autocmd BufEnter *.{js,jsx,ts,tsx,json,html,css} set number
" Rainbow parentheses on startup
au FileType javascript,typescript,javascriptreact,typescriptreact,json,html,css call rainbow#load()
" Enable vertical line in coding files
au FileType javascript,typescript,javascriptreact,typescriptreact set colorcolumn=80
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=200
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes
