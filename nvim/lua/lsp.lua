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

-- Coq related stuff
require 'coq-lsp'.setup {
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
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	-- Sets the "workspace" to the directory where any of these files is found.
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		".git",
	},
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				library = {
					"/usr/share/nvim/runtime/"
				}
			}
		}
	}
}

vim.lsp.enable('pylsp')
vim.lsp.enable('clangd')
vim.lsp.enable('ocamllsp ')
vim.lsp.enable('ts_ls')
vim.lsp.enable('lua_ls')
