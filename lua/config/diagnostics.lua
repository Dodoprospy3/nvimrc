-- LazyVim-style diagnostic UI.
-- Docs: :h vim.diagnostic.config()
--
-- Display only; the one exception is the <leader>vl keymap, which swaps a
-- line's inline messages for full virtual lines (see below). No plugins, no
-- icons: everything that is not set here uses Neovim's own defaults (default
-- sign column letters E/W/I/H, default virtual text prefix ■).

-- Buffer-local state: the 0-indexed line whose inline messages have been
-- swapped for virtual lines via <leader>vl, or nil when in the normal
-- (inline-only) state. Read by the two `format` functions below.
local function swap_line(bufnr)
    return vim.b[bufnr].diag_swap_line
end

vim.diagnostic.config({
    -- Refresh diagnostics on |InsertLeave| instead of on every keystroke,
    -- so the UI does not flicker while typing.
    update_in_insert = false,

    -- Order by severity (ERROR > WARN > INFO > HINT) for signs, virtual
    -- text, virtual lines and floats.
    severity_sort = true,

    -- Underline/undercurl the diagnostic range (DiagnosticUnderline*).
    underline = true,

    -- Sign column: left at Neovim's default (signs = true -> letters
    -- E / W / I / H, |diagnostic-signs|).

    -- Inline messages beside the code (the ■ squares + last message). This
    -- is the DEFAULT and, unless armed, the ONLY place messages appear.
    --
    -- `format` gates per line: on the line armed by <leader>vl it returns
    -- nil for every diagnostic, which makes _get_virt_text_chunks() drop the
    -- whole line's inline (no ■ squares, no message) -- that line is shown
    -- instead as virtual lines below (see virtual_lines). Every other line
    -- returns the message unchanged, so it renders exactly like Neovim's
    -- default (one ■ per diagnostic + the last message).
    --
    -- `source` is applied AFTER format (handlers.virtual_text), so it still
    -- appends "(source)" on non-armed lines as before.
    virtual_text = {
        spacing = 4,
        source = "if_many",
        format = function(diagnostic)
            if swap_line(diagnostic.bufnr) == diagnostic.lnum then
                return nil -- armed line: inline removed, shown below instead
            end
            return diagnostic.message
        end,
    },

    -- Full message(s) on the virtual lines below the line. DISABLED by
    -- default: format returns nil unless the line was armed by <leader>vl.
    -- When armed it prints EVERY diagnostic on that line (inline is gone for
    -- that line, so nothing is duplicated). `current_line = true` scopes
    -- rendering to the cursor line, which is always the armed line while
    -- armed.
    virtual_lines = {
        current_line = true,
        format = function(diagnostic)
            if swap_line(diagnostic.bufnr) ~= diagnostic.lnum then
                return nil -- only the <leader>vl-armed line gets virtual lines
            end
            if diagnostic.code then
                return string.format("%s: %s", diagnostic.code, diagnostic.message)
            end
            return diagnostic.message
        end,
    },

    -- Detailed popup for |vim.diagnostic.open_float()|.
    float = {
        border = "rounded",
        source = "if_many",
    },
})

-- <leader>vl: swap the current line's inline messages for virtual lines.
-- Only lines with more than one diagnostic qualify (a single message already
-- reads fine inline). Pressing it again on the same line swaps back.
vim.keymap.set("n", "<leader>vl", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lnum = vim.fn.line(".") - 1 -- 0-indexed, matches diagnostics
    if swap_line(bufnr) == lnum then
        vim.b[bufnr].diag_swap_line = nil -- toggle back to inline
    elseif #vim.diagnostic.get(bufnr, { lnum = lnum }) > 1 then
        vim.b[bufnr].diag_swap_line = lnum -- arm: inline -> virtual lines
    else
        return -- not armed and not enough diagnostics: nothing to swap
    end
    vim.diagnostic.show(nil, bufnr) -- re-render with the new armed line
end, { desc = "Swap line errors inline <-> virtual lines" })

-- Swap back to inline-only when the cursor LEAVES the armed line. Moving or
-- editing WITHIN the armed line does not reset (its line number is
-- unchanged), so the view stays until you go to a different line. The
-- re-render is deferred with vim.schedule so it does not run inside the
-- CursorMoved autocmd.
vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("config.diagnostics.swap", { clear = true }),
    callback = function(ev)
        local bufnr = ev.buf
        local armed = vim.b[bufnr].diag_swap_line
        if armed ~= nil and vim.fn.line(".") - 1 ~= armed then
            vim.b[bufnr].diag_swap_line = nil
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(bufnr) then
                    vim.diagnostic.show(nil, bufnr)
                end
            end)
        end
    end,
})

-- Diagnostic counts in the statusline, e.g. "E:2 W:3".
--
-- vim.diagnostic.status() returns ready-made statusline text with the
-- severity highlight already baked in (%#DiagnosticSignError#E:2 ...),
-- using nvim's default E/W/I/H letters (no Nerd Font). Severities with
-- zero count are omitted, so nothing shows on a clean buffer. nvim
-- redraws the statusline on |DiagnosticChanged| itself, so no autocmd
-- is needed here.
--
-- The %{%...%} double-brace form is required: it tells the statusline
-- to interpret the returned %#...# codes as highlights instead of
-- printing them literally.
vim.o.statusline = table.concat({
    -- Left: file name + help/preview/modified/readonly flags
    " %f %h%w%m%r",
    -- Everything after %= is right-aligned
    "%=",
    -- Right: diagnostic counts, cursor position, scroll percentage
    " %{%v:lua.vim.diagnostic.status()%}  %l:%c  %P ",
})
