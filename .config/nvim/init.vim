" ~/.config/nvim/init.vim - Simple starter config
" Start minimal, add plugins later as needed

" Basic settings
set number                " Show line numbers
set relativenumber        " Relative line numbers
set mouse=a               " Enable mouse
set clipboard=unnamedplus " Use system clipboard
set ignorecase            " Case insensitive search
set smartcase             " Unless uppercase is used
set incsearch             " Incremental search
set hlsearch              " Highlight search
set expandtab             " Use spaces instead of tabs
set shiftwidth=2          " Indent with 2 spaces
set tabstop=2             " Tab = 2 spaces
set softtabstop=2
set autoindent            " Copy indent from current line
set smartindent           " Smart indenting
set wrap                  " Wrap long lines
set cursorline            " Highlight current line
set termguicolors         " True color support
set scrolloff=8           " Keep 8 lines above/below cursor
set signcolumn=yes        " Always show sign column

" Leader key
let mapleader = " "

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Color scheme (use built-in for now)
colorscheme habamax
