pcall(function()
    local util = require('louis.util')

    require('nvim-tree').setup({
        view = {
            adaptive_size = true,
        },
        renderer = {
            add_trailing = true,
            icons = {
                show = {
                    file = false,
                    folder = false,
                    folder_arrow = false,
                    git = false,
                }
            }
        }
    })

    util.ncmd('<leader>t', 'NvimTreeFindFile')
end)
