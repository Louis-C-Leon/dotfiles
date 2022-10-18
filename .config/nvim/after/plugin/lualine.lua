local function config()
    require('lualine').setup({
        options = {
            icons_enabled = false,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {'NvimTree', 'fugitive', 'git'},
            },
        },
        globalstatus = true,
        sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'branch', 'diff', 'diagnostics' },
            lualine_x = { 'filetype', 'progress', 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        winbar = {
            lualine_b = { { 'filename', path = 1 } }
        },
        inactive_winbar = {
            lualine_b = { { 'filename', path = 1 } }
        }

    })
end

pcall(config)
