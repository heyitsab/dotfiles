" ~/.config/nvim/init.vim - Simple starter config

" ============================================================================
" VIM-PLUG SETUP
" ============================================================================
" Auto-install vim-plug if not present
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin list
call plug#begin(stdpath('data') . '/plugged')

" Color scheme
Plug 'morhetz/gruvbox'

" File tree
Plug 'nvim-tree/nvim-web-devicons'  " Icons (requires Nerd Font)
Plug 'nvim-tree/nvim-tree.lua'

" Fuzzy finder with preview
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" ============================================================================
" BASIC SETTINGS
" ============================================================================
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

" ============================================================================
" COLOR SCHEME
" ============================================================================
set background=dark
colorscheme gruvbox

" ============================================================================
" KEY MAPPINGS
" ============================================================================
" Leader key
let mapleader = ","

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" Create splits
nnoremap <leader>- :split<CR>
nnoremap <leader>\ :vsplit<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" File tree toggle
nnoremap <leader>e :NvimTreeToggle<CR>

" Fuzzy finder keybindings
nnoremap <leader>f :Files<CR>           " Find files
nnoremap <leader>g :Rg<CR>              " Search content (ripgrep)
nnoremap <leader>b :Buffers<CR>         " Search open buffers

" ============================================================================
" PLUGIN CONFIGURATION
" ============================================================================

" FZF - Enable preview window
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Nvim-tree setup (Lua configuration)
lua << EOF
require("nvim-tree").setup({
  view = {
    width = 30,
  },
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,  -- Show hidden files
  },
})
EOF
