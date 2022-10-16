local function config()
    vim.cmd'TSUpdate'
    require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<C-a>',
                node_incremental = '<C-a>'
            }
        },
        indent = { enable = true }
    }
end

pcall(config)
