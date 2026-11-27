-- lua/config/transparency.lua

local M = {}

local groups = {
    "Normal",
    "NormalNC",
    "EndOfBuffer",
    "SignColumn",
    "LineNr",
    "CursorLineNr",
    "FoldColumn",
    "WinSeparator",
    "FloatBorder",
}

function M.apply()
    for _, name in ipairs(groups) do
        vim.api.nvim_set_hl(0, name, { bg = "NONE" })
    end
end

local augroup = vim.api.nvim_create_augroup(
    "TransparentBackground",
    { clear = true }
)

vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    callback = M.apply,
})

M.apply()

return M
