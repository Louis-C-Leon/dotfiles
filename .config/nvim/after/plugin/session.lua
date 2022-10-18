local function restore_session()
    local session_path = vim.fn.getcwd() .. '/.session.vim'
    if vim.fn.filereadable(session_path) then
        local restore_cmd = 'so ' .. session_path
        vim.cmd(restore_cmd)
    end
end

-- quickfix list and filetree don't work when restoring sessions
local function save_session()
    vim.cmd.cclose()
    vim.cmd('NvimTreeClose')
    vim.cmd('mksession! ' .. vim.fn.getcwd() .. '/.session.vim')
end

-- save session in cwd whenever I quit nvim
vim.api.nvim_create_autocmd(
    'VimLeave',
    {
        group = vim.api.nvim_create_augroup(
            'AutoWriteSession',
            { clear = true }
        ),
        pattern = '*',
        callback = save_session
    }
)

-- set keymap to restore session
vim.keymap.set('n', '<leader>r', restore_session, { noremap = true, silent = true })
