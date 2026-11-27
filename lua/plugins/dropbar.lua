return {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  opts = {
    bar = {
      enable = false,
    },
  },
  config = function(_, opts)
    require('dropbar').setup(opts)

    local dropbar_api = require('dropbar.api')
    vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

    -- Toggle dropbar visibility on demand
    vim.keymap.set('n', '<Leader>tb', function()
      if vim.wo.winbar:find('dropbar') then
        vim.wo.winbar = ''
      else
        vim.wo.winbar = '%{%v:lua.dropbar()%}'
      end
    end, { desc = 'Toggle dropbar winbar' })

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
}
