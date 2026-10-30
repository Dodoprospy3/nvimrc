return {
    {
        "saghen/blink.cmp",
        version = "1.*",

        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        opts = {
            keymap = {
                preset = "none",

                -- Tab: jump to the next snippet placeholder, otherwise cycle the menu,
                -- otherwise fall through to the native <Tab> (indent / i_CTRL-N)
                ["<Tab>"] = {
                    "snippet_forward",
                    "select_next",
                    "fallback",
                },

                ["<S-Tab>"] = {
                    "snippet_backward",
                    "select_prev",
                    "fallback",
                },

                ["<CR>"] = {
                    "accept",
                    "fallback",
                },

                -- Menu navigation without leaving the home row
                ["<C-n>"] = {
                    "select_next",
                    "fallback",
                },

                ["<C-p>"] = {
                    "select_prev",
                    "fallback",
                },

                -- Manual trigger / toggle docs
                ["<C-space>"] = {
                    "show",
                    "show_documentation",
                    "hide_documentation",
                    "fallback",
                },

                -- Dismiss the menu (keeps <C-e> from deleting to end of line)
                ["<C-e>"] = {
                    "cancel",
                    "fallback",
                },

                -- Scroll the documentation window
                ["<C-b>"] = {
                    "scroll_documentation_up",
                    "fallback",
                },

                ["<C-f>"] = {
                    "scroll_documentation_down",
                    "fallback",
                },

                -- Toggle signature help (handy for JS/TS function arguments)
                ["<C-k>"] = {
                    "show_signature",
                    "hide_signature",
                    "fallback",
                },
            },

            completion = {
                documentation = {
                    -- Show the docs window automatically when an item is
                    -- highlighted (was manual-only via <C-space>).
                    auto_show = true,
                    auto_show_delay_ms = 250,

                    window = {
                        -- Rounded docs window, matching the diagnostic float.
                        border = "rounded",
                    },
                },

                -- NOTE: the completion *menu* is deliberately left at its
                -- default border (nil = none), so it stays un-rounded.
            },

            -- Inline signature help popup while typing call arguments
            signature = {
                enabled = true,
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },
        },
    },
}
