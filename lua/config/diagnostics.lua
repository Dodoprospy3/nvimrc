-- ============================================================
-- Diagnostic configuration
-- ============================================================

vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    underline = true,
    signs = vim.g.have_nerd_fonts and {
        Error = "Error",
        Warn = "Warn",
        Info = "",
        Hint = "",
    } or { Error = "E", Warn = "W", Info = " ", Hint = " " },
    virtual_text = {
        spacing = 4,
        source = "if_many",
    },
    virtual_lines = false,
    float = true,
})
