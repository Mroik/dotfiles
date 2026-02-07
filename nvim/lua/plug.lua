local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- Collection of common configurations for the Nvim LSP client
Plug('neovim/nvim-lspconfig')

-- Completion framework
Plug('hrsh7th/nvim-cmp')

-- LSP completion source for nvim-cmp
Plug('hrsh7th/cmp-nvim-lsp')

-- Snippet completion source for nvim-cmp
Plug('hrsh7th/cmp-vsnip')

-- Other usefull completion sources
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-buffer')

-- See hrsh7th's other plugins for more completion sources!

-- DO NOT run nvim-lspconfig
Plug('mrcjkb/rustaceanvim')

-- Snippet engine
Plug('hrsh7th/vim-vsnip')

-- Git symbols
Plug('mhinz/vim-signify')

-- fuzzy finder
Plug('junegunn/fzf.vim')

-- Coq autocomplete and stuff
Plug('whonore/Coqtail') -- for ftdetect, syntax, basic ftplugin, etc
Plug('tomtomjhj/coq-lsp.nvim')
vim.call('plug#end')
