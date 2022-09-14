" My config
set number
set cc=121
set tabstop=4
set shiftwidth=4
set mouse=a
set laststatus=0

colorscheme mycmp

nmap <F1> :NERDTree<enter>

" Remember position (nvim doesn't have it by default. Kinda dumb tbh)
autocmd BufRead * autocmd FileType <buffer> ++once 
	\ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif


call plug#begin()
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Git symbols
Plug 'mhinz/vim-signify'

" fuzzy finder
Plug 'junegunn/fzf.vim'

" Project tree
Plug 'scrooloose/nerdtree'
call plug#end()


" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c


" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.keymap.set('n', '<F4>', vim.lsp.buf.definition, { noremap=true, silent=true, buffer=bufnr })
	vim.keymap.set('n', '<F3>', vim.lsp.buf.hover, { noremap=true, silent=true, buffer=bufnr })
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
		vim.lsp.handlers.hover, {
			border = "rounded"
		}
	)
end

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
		hover_actions = {auto_focus = true},
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF


lua <<EOF
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.keymap.set('n', '<F4>', vim.lsp.buf.definition, { noremap=true, silent=true, buffer=bufnr })
	vim.keymap.set('n', '<F3>', vim.lsp.buf.hover, { noremap=true, silent=true, buffer=bufnr })
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
		vim.lsp.handlers.hover, {
			border = "rounded"
		}
	)
end

require'lspconfig'.pylsp.setup {
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = {'W391'},
					maxLineLength = 120
				}
			}
		}
	}
}
EOF


" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
  window = {
	  completion = cmp.config.window.bordered(),
	  documentation = cmp.config.window.bordered(),
  },
})
EOF


" Signify conf
let g:signify_sign_show_count = 0
