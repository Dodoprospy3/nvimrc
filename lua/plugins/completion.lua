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

                -- Manual trigger
                ["<C-space>"] = {
                    "show",
                    "fallback",
                },

                -- Dismiss the menu (keeps <C-e> from deleting to end of line)
                ["<C-e>"] = {
                    "cancel",
                    "fallback",
                },

                ["<C-k>"] = { "fallback" },
            },

            -- Signature help: disabled entirely.
            signature = { enabled = false },

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
