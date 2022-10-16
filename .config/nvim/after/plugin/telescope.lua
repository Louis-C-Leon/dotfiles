local function config()
    local util = require('louis.util')
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup {
        defaults = {
            file_ignore_patterns = { 'Pods', '.git' },
            mappings = {
                i = {
                    ['<esc>'] = actions.close,
                    ['<C-[>'] = actions.close,
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous
                }
            }
        },
        pickers = {
            find_files = {
                hidden = true,
            }
        },
    }

    telescope.load_extension('fzy_native')

    util.ncmd('<leader>f', 'Telescope find_files')
    util.ncmd('<leader>h', 'Telescope oldfiles')
    util.ncmd('<leader>o', 'Telescope buffers')
    util.ncmd('<leader>/', 'Telescope current_buffer_fuzzy_find')
    util.ncmd('<leader>s', 'Telescope live_grep')
    util.ncmd('<leader>w', 'Telescope grep_string')
    util.ncmd('<leader>b', 'Telescope git_branches')
    util.ncmd('<leader>z', 'Telescope diagnostics')
    util.ncmd('<leader>i', 'Telescope lsp_implementations')
    util.ncmd('<leader>q', 'Telescope quickfix')
    util.ncmd('gl', 'Telescope git_commits')
    util.ncmd('gh', 'Telescope git_bcommits')
    util.ncmd('gs', 'Telescope git_stash')
    util.ncmd('gd', 'Telescope lsp_definitions')
    util.ncmd('gt', 'Telescope lsp_type_definitions')
    util.ncmd('gr', 'Telescope lsp_references')
end



pcall(config)
