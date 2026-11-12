vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.colorcolumn = "80"

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.smartindent = true

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(vim.o.undodir) == 0 then
    vim.fn.mkdir(vim.o.undodir, "p")
end

-- Keep undo history for the long haul. The default of 1000 changes is tiny
-- for a file edited over months/years; older branches are silently discarded
-- (and then dropped from the persistent undo file on the next write).
-- 10000 undo blocks is still years of normal editing for a single file, at a
-- much lower memory cost than going higher.
vim.opt.undolevels = 10000
-- Also keep undo history across :e! reloads of large files (default is 10000).
vim.opt.undoreload = 10000

-- Read old undo files from previous locations too. The first existing undo
-- file wins and writes always go to the first entry, so this recovers history
-- orphaned by past 'undodir' changes without moving or merging files.
local undo_dirs = { vim.fn.stdpath("data") .. "/undo" }
for _, dir in ipairs({
    vim.fn.stdpath("state") .. "/undo",
    vim.fn.fnamemodify(vim.fn.stdpath("data"), ":h") .. "/nvim.bak/undo",
}) do
    if vim.fn.isdirectory(dir) == 1 then
        undo_dirs[#undo_dirs + 1] = dir
    end
end
vim.opt.undodir = table.concat(undo_dirs, ",")

vim.g.netrw_banner = 0

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Briefly highlight yanked text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})
