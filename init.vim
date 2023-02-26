lua << EOF

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  -- Set of defaults everyone can agree on
  Plug 'tpope/vim-sensible'

  -- Status bar at bottom of the screen
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  -- Unbelievable set of color schemes
  Plug 'flazz/vim-colorschemes'

  -- Distraction-free writing
  Plug 'junegunn/goyo.vim'
  -- nnoremap <C-g> :Goyo<CR>
  Plug 'junegunn/limelight.vim'

  -- Nightfly color scheme
  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'rebelot/kanagawa.nvim'

  -- Markdown editing
  Plug 'godlygeek/tabular'
  Plug 'SidOfc/mkdx'
  -- Uncomment if instant rendering is needed
  -- Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
  
  -- File explorer
  Plug 'preservim/nerdtree' 
  Plug 'jistr/vim-nertree-tabs'

  -- React development
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug ('styled-components/vim-styled-components', {branch='main'})
  Plug 'jparise/vim-graphql'
  -- Autocompletion for JS/TS
  Plug ('neoclide/coc.nvim', {branch='release'})
  -- Rainbow parentheses
  Plug 'frazrepo/vim-rainbow'
  -- Indent guides
  Plug 'nathanaelkane/vim-indent-guides'
  -- Brackets auto-closing
  Plug 'raimondi/delimitmate'
  -- Git hints
  Plug 'airblade/vim-gitgutter'
  -- Commenting tools
  Plug 'scrooloose/nerdcommenter'

vim.call('plug#end')

-- Custom <leader> key
vim.g.mapleader = ","

vim.opt.encoding = "utf-8"
vim.opt.background = "dark"
vim.opt.termguicolors = true
--  Airline theme definition
vim.g.airline_theme = "minimalist"

--  Disable compatibility with vi, which can cause unexpected issues.
vim.g.compatible = false
-- Set tab width
vim.opt.tabstop = 2
-- The same but for indents
vim.opt.shiftwidth = 2
-- Keep cursor in approximately the middle of the screen
vim.opt.scrolloff = 12
-- Do not save backup files.
vim.opt.backup = false
vim.opt.writebackup = false
-- Do not wrap lines when overflowing the screen width
vim.opt.wrap = false
-- Converts tabs to spaces
vim.opt.expandtab = true
--  Disable mouse support
vim.opt.mouse = ''

-- Theme definition
vim.cmd([[ colorscheme kanagawa ]])

--  Enable type file detection. Vim will be able to try to detect the type of file in use.
vim.cmd([[ filetype on ]])
-- Enable plugins and load plugin for the detected file type.
vim.cmd([[ filetype plugin on ]])
-- Load an indent file for the detected file type.
vim.cmd([[ filetype indent on ]])
-- Turn syntax highlighting on.
vim.cmd([[ syntax on ]])

function execIfMarkdown(command)
  return vim.api.nvim_exec('autocmd FileType markdown' .. ' lua ' .. command, false)
end

-- Markdown editing configuration
execIfMarkdown('vim.opt.wrap = true')
execIfMarkdown('vim.opt.linebreak = true')
execIfMarkdown('vim.opt.cursorline = true')
execIfMarkdown("vim.api.nvim_command('setlocal spell')")
execIfMarkdown("vim.api.nvim_buf_set_option(0, 'spelllang', 'fr')")
execIfMarkdown("vim.cmd([[ Goyo 100 ]])")

-- Configuration for vim-markdown
vim.g.vim_markdown_conceal = 2
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_toml_frontmatter = 1
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_strikethrough = 1
vim.g.vim_markdown_autowrite = 1
vim.g.vim_markdown_edit_url_in = 'tab'
vim.g.vim_markdown_follow_anchor = 1

EOF

" Development
" File explorer
if empty(argv())
    au VimEnter * NERDTree
endif

autocmd FileType javascript typescript json html css let g:nerdtree_tabs_open_on_console_startup=1
" Enable line numbering for Web development
autocmd BufEnter *.{js,jsx,ts,tsx,json,html,css} set number

" Rainbow parentheses on startup
au FileType javascript,typescript,javascriptreact,typescriptreact,json,html,css call rainbow#load()
" Enable vertical line in coding files
au FileType javascript,typescript,javascriptreact,typescriptreact set colorcolumn=80

" React syntax highlighting for large files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Coc configuration

" coc-git support for vim-airline
function! s:update_git_status()
  let g:airline_section_b = "%{get(g:,'coc_git_status','')}"
endfunction

lua << EOF
vim.g.airline_section_b = "%{get(g:,'coc_git_status','')}"
EOF

autocmd User CocGitStatusChange call s:update_git_status()

" Highlight current symbol on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Link to linters if present in project dependencies
lua << EOF

vim.g.coc_global_extensions = {}

EOF
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

lua << EOF

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.g.updatetime = 300
-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved
vim.g.signcolumn = "yes"

EOF

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

lua << EOF
vim.g.statusline = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"
EOF

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Show diagnostic if exists for word under cursor, else show docs
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

nnoremap <silent><nowait> <space>d  :<C-u>CocDiagnostics<cr>
