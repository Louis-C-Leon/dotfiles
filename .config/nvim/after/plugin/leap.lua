pcall(function()
    local leap = require('leap')
    leap.setup({
        case_sensitive = true,
        labels = {
            's', 'n', 'j', 'k', 'l', 'h', 'o', 'd', 'w', 'e', 'm', 'b',
            'u', 'y', 'v', 'r', 'g', 'c', 'x', '/', 'z', 'S', 'N', 'J', 'K',
            'L', 'H', 'O', 'D', 'W', 'E', 'M', 'B', 'U', 'Y', 'V', 'R', 'G',
            'C', 'X', '?', 'Z'
        }
    })
    leap.add_default_mappings()
end)
