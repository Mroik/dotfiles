local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Collection of common configurations for the Nvim LSP client
Plug('neovim/nvim-lspconfig')

-- Completion framework
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/vim-vsnip')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-buffer')

-- See hrsh7th's other plugins for more completion sources!

-- DO NOT run nvim-lspconfig
Plug('mrcjkb/rustaceanvim')

-- Snippet engine
Plug('hrsh7th/vim-vsnip')

-- Git symbols
Plug('mhinz/vim-signify')

-- Git blame
Plug('FabijanZulj/blame.nvim')

-- fuzzy finder
Plug('junegunn/fzf.vim')

-- Coq autocomplete and stuff
Plug('whonore/Coqtail') -- for ftdetect, syntax, basic ftplugin, etc
Plug('tomtomjhj/coq-lsp.nvim')

vim.call('plug#end')
