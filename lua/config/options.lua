vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.colorcolumn = "80"

vim.opt.smartindent = true

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(vim.o.undodir) == 0 then
    vim.fn.mkdir(vim.o.undodir, "p")
end
