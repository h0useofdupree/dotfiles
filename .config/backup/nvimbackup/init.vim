" Import Lua config
"lua require('plugins')

"{{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

"Plug 'davidhalter/jedi-vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'karb94/neoscroll.nvim'
Plug 'mattn/emmet-vim'
Plug 'sidebar-nvim/sidebar.nvim'
Plug 'dylanaraps/wal.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'junegunn/seoul256.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'stevearc/vim-arduino'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-python/python-syntax'
Plug 'hrsh7th/nvim-cmp'
Plug 'khaveesh/vim-fish-syntax'

call plug#end()
"}}}

"{{{ Deoplete Config
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow
"}}}
"{{{ Basic Config
"
" Absolute and Relative Line Numbers
set number relativenumber

" Foldmethod for non supported languages
set foldmethod=marker

" Smooth scrolling 
lua require('neoscroll').setup()

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
"set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000
"}}}
"{{{ Jedi Config 
" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
" }}}
"{{{ Neomake Config 
let g:neomake_python_enabled_makers = ['pylint']
"}}}
"{{{ NERDTree Config 
" Startup with cursor in Editor 
"augroup nerdtree_open autocmd! autocmd VimEnter * NERDTree | wincmd p augroup 

" Toggle Tree Keybind 
nnoremap <silent> <C-k><C-b> :NERDTreeToggle<CR> " Vim-Plug
"}}}
"{{{Python Syntax
let g:python_highlight_string_format = 1
let g:python_highlight_builtin_objs  = 1
"}}}
"{{{CoC Keybinds
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"}}}
"{{{General Keybinds
"Esc to jj
inoremap jj <Esc> 
"}}}

"{{{LaTeXLive/PDFTex
" Auto Indent
filetype indent on
" Invoke LaTeX Suite
filetype plugin on
" Automatic Vim7 filetype fix
let g:tex_flavor='latex'
"}}}

"{{{CSharpKeyBinds
" Find Usings: Find usings current smybol under cursor
nnoremap('<leader>fu', 'Telescope lsp_references')
" GoTo Definitions: Jump to definition of curr
nnoremap('<leader>gd', 'Telescope lsp_definitions')
nnoremap('<leader>rn', 'lua vim.lsp.buf.rename()')
nnoremap('<leader>dn', 'lua vim.lsp.diagnostic.goto_next()')
nnoremap('<leader>dN', 'lua vim.lsp.diagnostic.goto_prev()')
nnoremap('<leader>dd', 'Telescope lsp_document_diagnostics')
nnoremap('<leader>dD', 'Telescope lsp_workspace_diagnostics')
nnoremap('<leader>xx', 'Telescope lsp_code_actions')
nnoremap('<leader>xd', '%Telescope lsp_range_code_actions')

"}}}
"{{{ Theme Settings
"{{{2 Airline
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
"}}}2
"" NeoVim Theme 
syntax on
colorscheme gruvbox
" colorscheme seoul256
"}}}

