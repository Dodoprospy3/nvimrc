return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",

        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    prompt_prefix = "> ",
                    selection_caret = "> ",
                    entry_prefix = "  ",

                    -- TTY friendly
                    color_devicons = false,

                    -- Avoid Treesitter preview crashes
                    preview = {
                        treesitter = false,
                    },

                    -- Stop the fzy sorter from scoring 269k junk files.
                    -- Without telescope-fzf-native.nvim this is pure Lua and is the
                    -- #1 cause of the slowness you're seeing.
                    file_ignore_patterns = {
                        ".git/",
                        "node_modules/",
                        ".cache/",
                        ".cargo/",
                        ".npm/",
                        ".var/",
                        ".local/",
                        "dist/",
                        "build/",
                        "target/",
                        "%.lock",
                    },

                    mappings = {
                        i = {
                            ["<Esc>"] = actions.close,
                        },
                    },
                },

                pickers = {
                    find_files = {
                        -- hidden = true made `rg --files --hidden` return 269k files.
                        -- Keep it off unless you actually need dotfiles.
                        hidden = false,
                        disable_devicons = true,
                    },

                    live_grep = {
                        disable_devicons = true,
                        -- Scope grep so it doesn't crawl .git/node_modules/etc.
                        additional_args = function()
                            return { "--glob", "!**/.git/*", "--glob", "!**/node_modules/*" }
                        end,
                    },

                    buffers = {
                        disable_devicons = true,
                    },

                    git_files = {
                        disable_devicons = true,
                    },
                },
            })

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {
                desc = "Find Files",
            })

            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
                desc = "Live Grep",
            })

            vim.keymap.set("n", "<leader>fb", builtin.buffers, {
                desc = "Find Buffers",
            })

            -- Load the native fzf sorcer. Its setup() already overrides
            -- file_sorter and generic_sorter with the C-backed fzf sorcer,
            -- replacing the slow pure-Lua fzy sorcer.
            telescope.load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1 and vim.fn.executable("gcc") == 1
        end,
    },
}
