call plug#begin()
  " Set of defaults everyone can agree on
  Plug 'tpope/vim-sensible'

  " Status bar at bottom of the screen
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Unbelievable set of color schemes
  Plug 'flazz/vim-colorschemes'

  " Distraction-free writing
  Plug 'junegunn/goyo.vim'
  nnoremap <C-g> :Goyo<CR>
  Plug 'junegunn/limelight.vim'

  " Nightfly color scheme
  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'rebelot/kanagawa.nvim'

  " Markdown editing
  Plug 'godlygeek/tabular'
  Plug 'SidOfc/mkdx'
  " Uncomment if instant rendering is needed
  " Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
  
  " File explorer
  Plug 'preservim/nerdtree' 

  " Universal syntax highlighting
  Plug 'sheerun/vim-polyglot'

  " React development
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'jparise/vim-graphql'
  " Autocompletion for JS/TS
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Rainbow parentheses
  Plug 'frazrepo/vim-rainbow'
  " Indent guides
  Plug 'nathanaelkane/vim-indent-guides'
  " Brackets auto-closing
  Plug 'raimondi/delimitmate'
  " Git hints
  Plug 'airblade/vim-gitgutter'
  " Commenting tools
  Plug 'scrooloose/nerdcommenter'
call plug#end()

