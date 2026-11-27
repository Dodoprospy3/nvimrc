return {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  config = function()
    local dropbar_api = require('dropbar.api')
    vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

    local function set_dropbar_transparent()
      vim.api.nvim_set_hl(0, 'WinBar', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'WinBarNC', { bg = 'NONE' })
      -- Uncomment below if you also want the interactive dropdown menus transparent:
      -- vim.api.nvim_set_hl(0, 'DropBarMenuNormalFloat', { bg = 'NONE' })
    end

    set_dropbar_transparent()

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('DropbarTransparency', { clear = true }),
      callback = set_dropbar_transparent,
    })
    end,
    opts = {
        --[[
        icons = {
            enable = false,
            ui = {
                bar = { separator = ' > ', extends = '...' },
                menu = { separator = ' ', indicator = ' > ' },
            },
        },
        ]]--
    },
}
