return {
    {
        "christoomey/vim-tmux-navigator",
        -- Keymaps must exist from startup; there is nothing to lazy-load.
        lazy = false,
        -- Installs <C-h/j/k/l> for moving between Neovim splits and tmux
        -- panes. The tmux side is already set up in ~/.config/tmux/tmux.conf.
    },
}
