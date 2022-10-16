local util = require('louis.util')

-- save session in cwd whenever I quit nvim
vim.api.nvim_create_autocmd(
    'VimLeave',
    {
        group = vim.api.nvim_create_augroup(
            'AutoWriteSession',
            { clear = true }
        ),
        pattern = '*',
        callback = util.save_session
    }
)

-- set keymap to restore session
util.ncmd('<leader>r', 'lua require(\'louis.util\').restore_session()')
