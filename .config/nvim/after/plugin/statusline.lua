vim.opt.laststatus = 3

local statusline = {
    '%#ModeMsg#',
    '%{luaeval(\'require("louis.status-components").git_head()\')}%#WinBar#',
    '%#Comment#%l-%c',
    '%y',
    '%{luaeval(\'require("louis.status-components").lsp_clients()\')}',
}
vim.opt.statusline = table.concat(statusline, '  ')


local no_winbar_filetypes = { 'NvimTree', 'qf', 'fugitive' }
vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    {
        group = vim.api.nvim_create_augroup(
            'SetWinbar',
            { clear = true }
        ),
        pattern = '*',
        callback = function()
            local curr_ft = vim.bo.ft
            local disable_winbar = false
            for _, ft in ipairs(no_winbar_filetypes) do
                if curr_ft == ft then
                    disable_winbar = true
                    break
                end
            end
            if disable_winbar then
                vim.opt_local.winbar = nil
            else
                local winbar = {
                    '%#ModeMsg#%t%m',
                    '%#Comment#%{luaeval(\'require("louis.status-components").diagnostic_count()\')}',
                    '%{luaeval(\'require("louis.status-components").git_diff()\')}'
                }
                vim.opt_local.winbar = table.concat(winbar, '  ')
            end
        end
    }
)
