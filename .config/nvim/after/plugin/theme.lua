pcall(function()
    -- require('nightfox').setup({ options = { transparent = true } })
    -- vim.cmd('colorscheme terafox')
    require('kanagawa').setup({
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_gutter = "none"
                    }
                }
            }
        }
    })
    vim.cmd('colorscheme kanagawa')
end)
