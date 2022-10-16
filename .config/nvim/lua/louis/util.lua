local util = {}

function util.nmap(keys, result)
    vim.api.nvim_set_keymap('n', keys, result, { noremap = true })
end

function util.vmap(keys, result)
    vim.api.nvim_set_keymap('v', keys, result, { noremap = true })
end

function util.ncmd(keys, result)
    local cmd = '<cmd>' .. result .. '<CR>'
    vim.api.nvim_set_keymap('n', keys, cmd, { noremap = true })
end

function util.vcmd(keys, result)
    local cmd = '<cmd>' .. result .. '<CR>'
    vim.api.nvim_set_keymap('v', keys, cmd, { noremap = true })
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

-- open netrw, make it look like a normal file drawer, find current file
function util.open_netrw_to_curr_file()
    -- get path for current file (relative to cwd)
    local file_path = vim.fn.expand('%')

    -- use lua pattern to split string by '/' char; push into array
    local folder_paths = {}
    for substring in string.gmatch(file_path,'([^/]+)') do
        table.insert(folder_paths, substring)
    end

    -- open netrw to cwd
    vim.cmd('execute "Explore ."')

    -- go to top of tree
    vim.cmd('execute "normal gg"')

    -- find file if it's inside folders
    if table.getn(folder_paths) > 1 then
        for index, path in ipairs(folder_paths) do
            -- use vim search to find partial path
            vim.cmd('execute "/' .. path ..'"')
            vim.cmd('execute "normal n"')

            -- determine whether folder is expanded by checking next line.
            vim.cmd('execute "normal j"')
            local char_below = vim.fn.matchstr(
                vim.fn.getline('.'),
                [[\%]] .. vim.fn.col('.') .. 'c.'
            )
            vim.cmd('execute "normal k"')
            local is_expanded = char_below == '|'

            -- break loop if folder is already expanded, or if the current path
            -- points to a file instead of a folder
            if is_expanded or index == table.getn(folder_paths) then
                vim.cmd('execute "normal n"')
                break
            end
            vim.cmd([[execute "normal \<cr>"]])
        end
    end

end

return util
