return {
    {
        "williamboman/mason.nvim",
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },

        config = function()
            vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Python
                    "basedpyright",

                    -- Lua
                    "lua_ls",

                    -- Go
                    "gopls",

                    -- Rust
                    "rust_analyzer",

                    -- C
                    "clangd",

                    -- JavaScript / TypeScript
                    "vtsls",

                    -- Web
                    "html",
                    "cssls",
                    "emmet_ls",

                    -- JSON / JSONC
                    "jsonls",

                    -- Config files
                    "bashls",
                    "yamlls",
                },
            })

            -- Give EVERY server blink.cmp's full capability set (snippets,
            -- completion resolve, etc.). Previously only vtsls got these.
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- JavaScript / TypeScript
            vim.lsp.config("vtsls", {
                root_dir = function(bufnr, on_dir)
                    local root = vim.fs.root(bufnr, {
                        "package.json",
                        "tsconfig.json",
                        "jsconfig.json",
                        ".git",
                    })

                    on_dir(root or vim.fn.getcwd())
                end,

                -- Type-check plain JavaScript files that are NOT part of a
                -- project (no jsconfig/tsconfig). Without this, tsserver only
                -- reports "could not find name / property may not exist" as
                -- low-severity HINTS (severity 4), so they never show up as
                -- real errors. A project's own jsconfig/tsconfig still
                -- overrides this per-project. `js/ts` is the exact section
                -- vtsls requests (see its configuration.schema.json).
                settings = {
                    ["js/ts"] = {
                        implicitProjectConfig = {
                            checkJs = true,
                        },
                    },
                },
            })

            -- HTML with embedded-language support
            vim.lsp.config("html", {
                -- The stock vscode-html-language-server (mason's html-lsp) has a
                -- hardcoded TypeScript lib path, so JS inside <script> tags gets no
                -- real IntelliSense (only word completions). This patched build
                -- resolves the TS lib at runtime, restoring completions, hover,
                -- go-to-def and diagnostics for inline JS.
                -- Installed with: npm i -g @t1ckbase/vscode-langservers-extracted
                cmd = { vim.fn.expand("~/.local/bin/vscode-html-language-server"), "--stdio" },

                init_options = {
                    embeddedLanguages = {
                        css = true,
                        javascript = true,
                    },
                    configurationSection = {
                        "html",
                        "css",
                        "javascript",
                    },
                },
            })

            -- Emmet abbreviation completion
            vim.lsp.config("emmet_ls", {
                filetypes = {
                    "html",
                    "css",
                    "javascript",
                    "javascriptreact",
                    "typescriptreact",
                },
            })

            -- Lua: tell lua_ls it's LuaJIT (Neovim's runtime) and point it at
            -- Neovim's runtime library, so `vim.*` resolves and LuaJIT-only
            -- syntax isn't reported as an error (fewer false positives).
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = {
                            globals = {
                                "vim",
                            },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    },
                },
            })

            -- ===================== Diagnostics-oriented settings =====================
            -- These aim for the *most complete error/warning detection* per
            -- language. Each block is deep-merged with nvim-lspconfig's
            -- defaults, so nothing defined there is lost.

            -- Python: basedpyright's default is already the strict
            -- "recommended" rule set (stricter than pyright's "standard");
            -- pin it explicitly so it can't be relaxed by a future default.
            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "recommended",
                        },
                    },
                },
            })

            -- Go: compile errors are always reported; add extra static
            -- analyses + the built-in staticcheck suite for more lint errors.
            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        staticcheck = true,
                        analyses = {
                            unusedparams = true,
                            unusedwrite = true,
                            nilness = true,
                            unusedresult = true,
                            composites = true,
                        },
                    },
                },
            })

            -- Rust: run clippy (installed) instead of plain `cargo check` on
            -- save for richer lint diagnostics. (Experimental diagnostics are
            -- left OFF: they produce false positives such as "unresolved
            -- macro println!" on otherwise-valid code.)
            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        check = { command = "clippy" },
                        diagnostics = { enable = true },
                    },
                },
            })

            -- YAML: validate against schema-store schemas (Actions,
            -- docker-compose, etc.).
            vim.lsp.config("yamlls", {
                settings = {
                    yaml = {
                        validate = true,
                        schemaStore = { enable = true },
                    },
                },
            })

            -- JSON: validate against schemas.
            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        validate = { enable = true },
                    },
                },
            })

            -- NOTE (C/C++): clangd only produces full diagnostics when a
            -- compile_commands.json (or compile_flags.txt) is present in the
            -- project root. Generate one, e.g.:
            --   cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..  &&  ln -s build/compile_commands.json .
            --   # or: bear -- make
            -- NOTE (Bash): bash-language-server runs shellcheck automatically
            -- when it's on PATH. Install it with:  :MasonInstall shellcheck

            vim.lsp.enable({
                -- Python
                "basedpyright",

                -- Lua
                "lua_ls",

                -- Go
                "gopls",

                -- Rust
                "rust_analyzer",

                -- C
                "clangd",

                -- JavaScript / TypeScript
                "vtsls",

                -- HTML / CSS
                "html",
                "cssls",
                "emmet_ls",

                -- JSON / JSONC
                "jsonls",

                -- Config files
                "bashls",
                "yamlls",
            })
        end,
    },
}
