-- settings to make it nicer to read markdown files
vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    {
        group = vim.api.nvim_create_augroup(
            'ConfigFileType',
            { clear = true }
        ),
        pattern = '*.md',
        callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
        end
    }
)
