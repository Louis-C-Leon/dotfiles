local function restore_session()
    vim.cmd('NvimTreeClose')
    local session_path = vim.fn.getcwd() .. '/.session.vim'
    if vim.fn.filereadable(session_path) then
        pcall(function() vim.cmd('silent so ' .. session_path) end)
    end
    require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
end

-- quickfix list and filetree don't work when restoring sessions
local function auto_session()
    local session_path = vim.fn.getcwd() .. '/.session.vim'
    vim.cmd.cclose()
    vim.cmd('NvimTreeClose')
    vim.cmd('mksession! ' .. session_path)
end

vim.api.nvim_create_autocmd(
    'VimLeave',
    {
        group = vim.api.nvim_create_augroup(
            'SaveSession',
            { clear = true }
        ),
        pattern = '*',
        callback = auto_session
    }
)

vim.keymap.set('n', '<leader>r', restore_session, { noremap = true, silent = true })
