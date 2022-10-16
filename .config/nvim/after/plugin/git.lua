local function config()
    local util = require('louis.util')

    require('gitsigns').setup({
        signcolumn = false,
        numhl = true,
    })

    -- vim-fugitive
    util.ncmd('<leader>g', 'Git')
    util.ncmd('<leader>p', 'Git pull')
    util.ncmd('<leader>P', 'Git push')
    util.ncmd('gL', 'Git log')
    util.ncmd('gB', 'Git blame --date=short')
    util.nmap('g<space>', ':Git<space>')
    util.nmap('<leader>c', ':Git commit -m ""<left>')

    -- vim-rhubarb
    util.ncmd('go', 'GBrowse')
    util.vcmd('go', 'GBrowse')

    -- gitsigns.nvim
    util.ncmd('gj', 'Gitsigns next_hunk')
    util.ncmd('gk', 'Gitsigns prev_hunk')
    util.nmap('gv', ':Gitsigns diffthis<space>')
end

pcall(config)
