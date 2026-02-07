require("bindings")
require("plug")
require("lsp")
require("autocomplete")
vim.opt.number = true
vim.opt.cc = "121"
vim.opt.textwidth = 120
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"
vim.opt.laststatus = 0

vim.cmd.colorscheme("dracula")

-- :help completeopt
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'fuzzy' }

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append('c')

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"

	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
