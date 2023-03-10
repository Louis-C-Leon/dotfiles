pcall(function()
    local opts = { noremap = true }
    require('gitsigns').setup()

    -- vim-fugitive
    vim.keymap.set('n', '<leader>g', '<cmd>bot Git<cr>', opts)
    vim.keymap.set('n', '<leader>p', '<cmd>echo "Git pull" | Git pull<cr>', opts)
    vim.keymap.set('n', '<leader>P', '<cmd>echo "Git push" | Git push<cr>', opts)
    vim.keymap.set('n', 'gl', '<cmd>vertical Git log<cr>', opts)
    vim.keymap.set('n', 'gb', '<cmd>Git blame --date=short<cr>', opts)
    vim.keymap.set('n', 'g<space>', ':Git<space>', opts)
    vim.keymap.set('n', '<leader>c', ':Git commit -m ""<left>', opts)

    -- vim-rhubarb
    vim.keymap.set('n', 'go', '<cmd>GBrowse<cr>', opts)
    vim.keymap.set('v', 'go', '<cmd>\'<,\'>GBrowse<cr>', opts)

    -- gitsigns.nvim
    vim.keymap.set('n', 'gj', '<cmd>Gitsigns next_hunk<cr>', opts)
    vim.keymap.set('n', 'gk', '<cmd>Gitsigns prev_hunk<cr>', opts)
    vim.keymap.set('n', 'gv', ':Gitsigns diffthis<space>', opts)
    vim.keymap.set('n', 'gV', ':DiffviewOpen<space>', opts)
end)
