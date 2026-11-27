return {
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        opts = {},

        config = function()
            require("trouble").setup()

            vim.keymap.set(
                "n",
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<CR>",
                {
                    desc = "Diagnostics",
                }
            )

            vim.keymap.set(
                "n",
                "<leader>xq",
                "<cmd>Trouble quickfix toggle<CR>",
                {
                    desc = "Quickfix list",
                }
            )
        end,
    },
}
