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
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" Fuzzy finder with preview
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Telescope - Better fuzzy finder with LSP integration
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" Snippets (required for completion to work properly)
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" Treesitter - Better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Tmux navigation
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" ============================================================================
" BASIC SETTINGS
" ============================================================================
" Suppress deprecation warnings on startup
set shortmess+=I

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

" Folding settings (will be enabled per-filetype after Treesitter loads)
set foldlevelstart=99     " Start with all folds open
set foldnestmax=10        " Max 10 fold levels

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

" Clear search highlight (Esc in normal mode)
nnoremap <Esc> :nohlsearch<CR>
nnoremap <leader>h :nohlsearch<CR>

" Create splits
nnoremap <leader>- :split<CR>
nnoremap <leader>\ :vsplit<CR>

" Split navigation (handled by vim-tmux-navigator)
" C-h, C-j, C-k, C-l will work seamlessly between vim and tmux

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" File tree toggle
nnoremap <leader>e :NvimTreeToggle<CR>

" Fuzzy finder keybindings
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>b :Buffers<CR>

" Telescope keybindings
nnoremap <leader>s :Telescope lsp_document_symbols<CR>
nnoremap <leader>S :Telescope lsp_dynamic_workspace_symbols<CR>
nnoremap <leader>o :Telescope oldfiles<CR>

" Code folding keybindings
nnoremap <Space> za
nnoremap zR zR
nnoremap zM zM

" Screen positioning / scrolling
nnoremap zt zt
nnoremap zz zz
nnoremap zb zb
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" LSP keybindings (will be set up after LSP attaches)
" gd - Go to definition
" gr - Find references
" K - Hover documentation
" <leader>r - Rename symbol
" <leader>a - Code actions
" [d / ]d - Previous/next diagnostic

" ============================================================================
" PLUGIN CONFIGURATION
" ============================================================================

" FZF - Enable preview window
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Nvim-tree setup
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
    dotfiles = false,
  },
})
EOF

" ============================================================================
" TREESITTER SETUP
" ============================================================================
lua << EOF
-- Only setup if treesitter is installed
local status_ok, treesitter = pcall(require, 'nvim-treesitter')
if status_ok then
  -- Setup treesitter
  treesitter.setup {
    install_dir = vim.fn.stdpath('data') .. '/site'
  }
  
  -- Install parsers for these languages
  local parsers = { 'go', 'typescript', 'javascript', 'tsx', 'ruby', 'lua', 'vim', 'vimdoc', 'markdown', 'json', 'yaml', 'html', 'css' }
  treesitter.install(parsers)
  
  -- Enable treesitter highlighting for supported filetypes
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'ruby', 'lua', 'vim', 'markdown', 'json', 'yaml', 'html', 'css' },
    callback = function()
      -- Only start treesitter if parser is available
      local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
      if lang and pcall(vim.treesitter.language.add, lang) then
        pcall(vim.treesitter.start)
        
        -- Enable treesitter-based folding
        vim.opt_local.foldmethod = 'expr'
        vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      end
    end,
  })
end
EOF

" ============================================================================
" TELESCOPE SETUP
" ============================================================================
lua << EOF
local status_ok, telescope = pcall(require, 'telescope')
if status_ok then
  telescope.setup({
    defaults = {
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      },
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
  })
end
EOF

" ============================================================================
" LSP & COMPLETION SETUP
" ============================================================================
lua << EOF
-- Suppress lspconfig deprecation warnings
vim.deprecate = function() end

-- Mason setup (LSP installer)
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Mason-lspconfig: auto-install these language servers
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",        -- TypeScript/JavaScript
    "gopls",        -- Go
    "ruby_lsp",     -- Ruby
  },
  automatic_installation = true,
})

-- Completion setup
local cmp = require('cmp')
local luasnip = require('luasnip')

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- LSP capabilities for completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP on_attach: keybindings and settings when LSP starts
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  
  -- Navigation
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  
  -- Documentation
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  
  -- Actions
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
  
  -- Diagnostics
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
  
  -- Format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
  
  -- Auto-imports (organize imports on save for supported languages)
  if client.server_capabilities.codeActionProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
        for _, res in pairs(result or {}) do
          for _, action in pairs(res.result or {}) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
            else
              vim.lsp.buf.execute_command(action.command)
            end
          end
        end
      end,
    })
  end
end

-- Configure language servers
local lspconfig = require('lspconfig')

-- TypeScript/JavaScript
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Go
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Ruby
lspconfig.ruby_lsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Diagnostic configuration (less noisy)
vim.diagnostic.config({
  virtual_text = false,  -- Don't show inline errors while typing
  signs = true,          -- Show signs in gutter
  underline = true,      -- Underline errors
  update_in_insert = false,  -- Don't update diagnostics while typing
  severity_sort = true,
})

-- Show diagnostics in a floating window on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
  end,
})

-- Faster update time for CursorHold
vim.opt.updatetime = 300

EOF
