vim.opt.number = true
vim.opt.cc = "121"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"
vim.opt.laststatus = 0

vim.cmd.colorscheme("dracula")

vim.keymap.set("n", "<F1>", vim.lsp.buf.format)
vim.keymap.set("n", "<F2>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<F3>", function() vim.lsp.buf.hover({border = "rounded"}) end)
vim.keymap.set("n", "<F4>", vim.lsp.buf.definition)
vim.keymap.set("n", "<F5>", vim.lsp.buf.references)
vim.keymap.set("n", "<F6>", vim.lsp.buf.rename)
vim.keymap.set("n", "<F7>", function() vim.diagnostic.open_float({border = "rounded"}) end)
vim.keymap.set("n", "<F8>", "<cmd>Commits<enter>")
vim.keymap.set("n", "<F9>", "<cmd>Rg<enter>")
vim.keymap.set("n", "<F11>", "<cmd>GFiles<enter>")
vim.keymap.set("n", "<F12>", "<cmd>Files<enter>")


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


-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append('c')

-- Config lsp for Rust
vim.g.rustaceanvim = {
	tools = {
		enable_clippy = false,
	},
}

vim.lsp.config.pylsp = {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					maxLineLength = 120,
				},
			}
		}
	}
}


vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--fallback-style=webkit"
	},
}

vim.lsp.enable('pylsp')
vim.lsp.enable('clangd')
vim.lsp.enable('ocamllsp ')
vim.lsp.enable('ts_ls')

-- Coq related stuff
require'coq-lsp'.setup {
  coq_lsp_nvim = {
    -- to be added
  },
  lsp = {
    -- coq-lsp server initialization configurations, defined here:
    -- https://github.com/ejgallego/coq-lsp/blob/main/editor/code/src/config.ts#L3
    -- Documentations are at https://github.com/ejgallego/coq-lsp/blob/main/editor/code/package.json.
    init_options = {
      show_notices_as_diagnostics = true,
    },
  },
}

vim.lsp.config.lua_ls = {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        --library = {
        --  vim.env.VIMRUNTIME,
        --  -- Depending on the usage, you might want to add additional paths here.
        --  -- "${3rd}/luv/library"
        --  -- "${3rd}/busted/library",
        --}
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}


-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
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
