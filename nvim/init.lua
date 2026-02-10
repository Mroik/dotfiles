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
vim.o.winborder = "rounded"

vim.cmd.colorscheme("dracula")

-- :help completeopt
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'fuzzy' }

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append('c')
