local util = {}

function util.nmap(keys, result)
    vim.keymap.set('n', keys, result, { noremap = true })
end

function util.vmap(keys, result)
    vim.keymap.set('v', keys, result, { noremap = true })
end

function util.ncmd(keys, result)
    local cmd = '<cmd>' .. result .. '<CR>'
    vim.keymap.set('n', keys, cmd, { noremap = true })
end

function util.vcmd(keys, result)
    local cmd = '<cmd>' .. result .. '<CR>'
    vim.keymap.set('v', keys, cmd, { noremap = true })
end

function util.save_session()
    vim.cmd('cclose')
    vim.cmd('wincmd o')
    vim.cmd('mksession! ' .. vim.fn.getcwd() .. '/.session.vim')
end

function util.restore_session()
    local session_path = vim.fn.getcwd() .. '/.session.vim'
    if vim.fn.filereadable(session_path) then
        local restore_cmd = 'so ' .. session_path
        vim.cmd(restore_cmd)
    end
end

return util
