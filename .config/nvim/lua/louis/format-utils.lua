local M = {}

M.break_into_lines = function(string, line_length)
    local original = string
    if original:len() < line_length then return original end

    local formatted = ''

    while original:len() >= line_length do
        local newline
        local chopped = original:sub(1, line_length)
        local reversed = chopped:reverse()
        local reverse_idx = reversed:find('%s')
        if reverse_idx == nil then
            newline = chopped
            original = original:sub(chopped:len() + 1)
            formatted = ('%s%s'):format(formatted, chopped)
        else
            local space_idx = chopped:len() - reverse_idx
            newline = chopped:sub(1, space_idx)
            original = original:sub(space_idx + 2)
        end
        if formatted:len() > 0 then
            formatted = ('%s\n%s'):format(formatted, newline)
        else
            formatted = newline
        end
    end
    if original:len() > 0 then
        formatted = ('%s\n%s'):format(formatted, original)
    end
    return formatted
end

return M
