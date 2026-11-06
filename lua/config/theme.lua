local M = {}

-- Custom UI highlights, reapplied whenever the colorscheme changes.
local function apply_custom_highlights()
  vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = "#ffff00",
    bold = true,
  })

--  vim.api.nvim_set_hl(0, "CursorLine", {
--    bg = "NONE",
--  })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_custom_highlights,
})

-- Apply immediately as well.
apply_custom_highlights()

return M
