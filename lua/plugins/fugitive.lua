return {
    "tpope/vim-fugitive",
    cmd = { "Git", "GitAll", "GitGutter", "GitMerge", "GitRequest" },
    keys = {
        { "<leader>gs", "<cmd>Git<cr>", desc = "Fugitive: Git status" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Fugitive: Commit" },
        { "<leader>gp", "<cmd>Git push<cr>", desc = "Fugitive: Push" },
        { "<leader>gl", "<cmd>Git log<cr>", desc = "Fugitive: Log" },
        { "<leader>gd", "<cmd>Git diff<cr>", desc = "Fugitive: Diff" },
        { "<leader>gb", "<cmd>Git blame<cr>", desc = "Fugitive: Blame" },
    },
    config = function()
        -- Fugitive doesn't require much setup,
        -- but we can add some convenient mappings
        vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Fugitive: status" })
    end,
}
