-- autocommands to set filetype if needed
vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    {
        group = vim.api.nvim_create_augroup(
            'ConfigFileType',
            { clear = true }
        ),
        pattern = '*.conf',
        callback = function() vim.cmd('set filetype=config') end
    }
)
