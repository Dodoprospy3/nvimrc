return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    html = { "prettier" },
                    css = { "prettier" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    json = { "prettier" },
                    markdown = { "prettier" },

                    -- Go: gofmt ships with the Go toolchain (already on PATH),
                    -- so this works immediately.
                    go = { "gofmt" },

                    -- Python: ruff_format (fast, Black-compatible output).
                    -- If the `ruff` binary is not installed yet, conform drops
                    -- it and <leader>fm falls back to the LSP (basedpyright).
                    python = { "ruff_format" },

                    -- Lua: stylua. Same graceful fallback to lua_ls when the
                    -- `stylua` binary is not installed yet.
                    lua = { "stylua" },
                },

                formatters = {
                    prettier = {
                        prepend_args = {
                            "--tab-width",
                            "4",
                        },
                    },

                    -- stylua defaults to TABS, but this config uses spaces
                    -- (expandtab + shiftwidth=4), so force 4-space indent to
                    -- match. Command-line args win over any .stylua.toml.
                    stylua = {
                        prepend_args = {
                            "--indent-type",
                            "Spaces",
                            "--indent-width",
                            "4",
                        },
                    },
                },

                format_on_save = false,
            })

            vim.keymap.set("n", "<leader>fm", function()
                require("conform").format({
                    -- Preferred over the deprecated `lsp_fallback = true`.
                    -- Falls back to the LSP's formatter when no conform
                    -- formatter is configured for the file (e.g. Python, Go).
                    lsp_format = "fallback",
                })
            end, { desc = "Format file" })
        end,
    },
}
