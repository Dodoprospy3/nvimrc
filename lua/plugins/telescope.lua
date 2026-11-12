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

                    -- Best match goes at the top, right under the prompt.
                    -- The default "descending" puts the best result at the bottom,
                    -- which makes the list look wrong/jumbled.
                    sorting_strategy = "ascending",

                    -- Keep the filename visible and trim the directory instead of
                    -- cutting off the part you actually searched for.
                    path_display = { "smart" },

                    -- Avoid Treesitter preview crashes
                    preview = {
                        treesitter = false,
                    },

                    -- Don't let module caches, package managers and plugin
                    -- checkouts pollute results when searching from ~.
                    file_ignore_patterns = {
                        ".git/",
                        "node_modules/",
                        ".cache/",
                        ".cargo/",
                        ".npm/",
                        ".var/",
                        ".local/",
                        ".rustup/",
                        ".oh-my-zsh/",
                        "go/pkg/",
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
                        show_untracked = true,
                    },
                },
            })

            -- In a git repo, search only that project (tracked + untracked,
            -- respecting .gitignore) instead of every file under ~.
            local function project_files()
                local inside = vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
                if vim.v.shell_error == 0 and vim.trim(inside) == "true" then
                    builtin.git_files({ show_untracked = true })
                else
                    builtin.find_files()
                end
            end

            vim.keymap.set("n", "<leader>ff", project_files, {
                desc = "Find Files (project)",
            })

            vim.keymap.set("n", "<leader>fF", builtin.find_files, {
                desc = "Find Files (cwd)",
            })

            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
                desc = "Live Grep",
            })

            vim.keymap.set("n", "<leader>fb", builtin.buffers, {
                desc = "Find Buffers",
            })

            -- Load the native fzf sorter. Its setup() already overrides
            -- file_sorter and generic_sorter with the C-backed fzf sorter,
            -- replacing the slow pure-Lua fzy sorter.
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
