return {
    {
        "Dodoprospy3/nvim-stupidy-pack",

        config = function()
            require("stupidy-pack").setup()
        end,
    },

    -- Cellular Automaton: melt your buffer when the deadline hits.
    -- Needs a treesitter parser for the current buffer.
    --   :CellularAutomaton make_it_rain
    --   :CellularAutomaton game_of_life
    {
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
        keys = {
            { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
        },
    },

    -- duck.nvim: release a duck that waddles across your code.
    -- Multiple ducks allowed; doesn't load until you summon one.
    {
        "tamton-aquib/duck.nvim",
        keys = {
            { "<leader>dd", function() require("duck").hatch() end, desc = "Hatch a duck" },
            { "<leader>dk", function() require("duck").cook() end, desc = "Cook a duck" },
            { "<leader>da", function() require("duck").cook_all() end, desc = "Cook all ducks" },
        },
    },

    -- typewriter.nvim: keeps the cursor centered while you type.
    -- NOTE: typewriter.vim (the "sounds" one) is NOT used -- it requires
    -- Vim9 +sound, which Neovim does not have.
    --   :TWToggle / :TWEnable / :TWDisable
    {
        "joshuadanpeterson/typewriter.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = { "TWToggle", "TWEnable", "TWDisable", "TWCenter", "TWTop", "TWBottom" },
        config = function()
            require("typewriter").setup()
        end,
    },

    -- dealwithit.vim: the dog slides in with sunglasses.
    -- Works in Neovim with 'termguicolors' (already set).
    --   :Dealwithit
    {
        "AndrewRadev/dealwithit.vim",
        cmd = "Dealwithit",
        keys = {
            { "<leader>di", "<cmd>Dealwithit<cr>", desc = "Deal with it" },
        },
    },
}
