-- ============================================================
-- Diagnostic configuration
-- ============================================================

local normal_config = {
    update_in_insert = false,
    severity_sort = true,
    underline = false,
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
}

vim.diagnostic.config(normal_config)

local diag_group = vim.api.nvim_create_augroup("config.diagnostics.normal_only", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
    group = diag_group,
    callback = function()
        local mode = vim.fn.mode()
        if mode == "n" then
            vim.diagnostic.config(normal_config)
        elseif not mode:match("^no") then
            vim.diagnostic.config({
                virtual_text = false,
                signs = false,
                underline = false,
            })
        end
    end,
})
