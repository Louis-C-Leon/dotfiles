local M = {}

M.git_head = function()
    local head = vim.b.gitsigns_head
    if not head then
        return ''
    else
        return head
    end
end

M.git_diff = function()
    local dict = vim.b.gitsigns_status_dict;
    if not dict then
        return ''
    elseif dict.added == 0 and dict.changed == 0 and dict.removed == 0 then
        return ''
    end
    local component = {}

    if (dict.added) then
        table.insert(component, '+')
        table.insert(component, dict.added)
        table.insert(component, ' ')
    end
    if (dict.changed) then
        table.insert(component, '~')
        table.insert(component, dict.changed)
        table.insert(component, ' ')
    end
    if (dict.removed) then
        table.insert(component, '-')
        table.insert(component, dict.removed)
        table.insert(component, ' ')
    end
    return table.concat(component)
end

M.diagnostic_count = function()
    local error = 0
    local warn = 0
    local info = 0
    local hint = 0
    local component = {}

    for _, v in ipairs(vim.diagnostic.get(0)) do
        if v.severity == vim.diagnostic.severity.ERROR then
            error = error + 1
        elseif v.severity == vim.diagnostic.severity.WARN then
            warn = warn + 1
        elseif v.severity == vim.diagnostic.severity.INFO then
            info = info + 1
        elseif v.severity == vim.diagnostic.severity.HINT then
            hint = hint + 1
        end
    end

    if error > 0 then
        table.insert(component, 'x')
        table.insert(component, error)
        table.insert(component, ' ')
    end
    if warn > 0 then
        table.insert(component, '!')
        table.insert(component, warn)
        table.insert(component, ' ')
    end
    if info > 0 then
        table.insert(component, 'i')
        table.insert(component, info)
        table.insert(component, ' ')
    end
    if hint > 0 then
        table.insert(component, '?')
        table.insert(component, hint)
        table.insert(component, ' ')
    end
    return table.concat(component)
end

M.lsp_clients = function()
    local component = {}
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
        table.insert(component, client.name)
    end
    return table.concat(component, ', ')
end

return M
