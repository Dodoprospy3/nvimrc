return {
    "stevearc/oil.nvim",

    dependencies = {
        { "nvim-mini/mini.icons", opts = {} },
    },

    lazy = false,

    opts = {
        default_file_explorer = false,

        -- Display columns
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
        },

        -- Buffer behavior
        buf_options = {
            buflisted = false,
            bufhidden = "hide",
        },

        win_options = {
            wrap = false,
            signcolumn = "no",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
        },

        -- Filesystem behavior
        delete_to_trash = true,
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 2000,
        watch_for_changes = true,

        -- LSP integration
        lsp_file_methods = {
            enabled = true,
            timeout_ms = 1000,
            autosave_changes = false,
        },

        constrain_cursor = "editable",

        -- Directory display
        view_options = {
            show_hidden = true,
            natural_order = true,
            case_insensitive = true,
        },

        -- Floating windows
        float = {
            padding = 2,
            max_width = 0.8,
            max_height = 0.8,
            border = "rounded",
            preview_split = "auto",
        },

        -- File previews
        preview_win = {
            update_on_cursor_moved = true,
            preview_method = "fast_scratch",
        },

        -- Keymaps
        keymaps = {
            ["g?"] = "actions.show_help",

            ["<CR>"] = "actions.select",
            ["<C-s>"] = {
                "actions.select",
                opts = { vertical = true },
            },
            ["<C-h>"] = {
                "actions.select",
                opts = { horizontal = true },
            },
            ["<C-t>"] = {
                "actions.select",
                opts = { tab = true },
            },

            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",

            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["g~"] = {
                "actions.cd",
                opts = { scope = "tab" },
            },

            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",

            -- Clipboard
            ["gy"] = "actions.copy_entry_path",
            ["y"] = "actions.yank_entry",
        },
    },

    keys = {
        {
            "-",
            "<CMD>Oil<CR>",
            desc = "Open Oil",
        },
        {
            "<leader>fo",
            "<CMD>Oil --float<CR>",
            desc = "Open Oil floating",
        },
    },
}
