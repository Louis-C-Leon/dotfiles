pcall(function()
    local opts = { noremap = true }
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')
    local action_state = require('telescope.actions.state')
    local utils = require('telescope.utils')

    telescope.setup({
        defaults = {
            file_ignore_patterns = { 'Pods/', '^%.git/' },
            layout_strategy = 'center',
            preview_cutoff = 0,
            layout_config = { height = 17 },
            sorting_strategy = 'ascending',
            prompt_prefix = '',
            selection_caret = '',
            entry_prefix = '',
            multi_icon = '',
            results_title = '',
            path_display = { shorten = 4 },
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--hidden'
            },
            mappings = {
                i = {
                    ['<esc>'] = actions.close,
                    ['<C-[>'] = actions.close,
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                    -- always open qflist with full width
                    ['<C-q>'] = function(bufnr)
                        actions.send_to_qflist(bufnr)
                        vim.cmd('botright copen')
                    end
                }
            }
        },
        pickers = {
            find_files = {
                layout_config = { height = 13 },
                hidden = true,
                previewer = false,
                theme = 'ivy'
            },
            live_grep = {
                layout_config = { height = 13 },
                prompt_title = 'Live Search',
                previewer = false,
                theme = 'ivy',
            },
            grep_string = {
                previewer = false,
                theme = 'ivy',
                layout_config = { height = 13 },
            },
            oldfiles = {
                prompt_title = 'Recent Files',
                previewer = false,
                theme = 'ivy',
                layout_config = { height = 13 },
            },
            buffers = {
                prompt_title = 'Current Files',
                previewer = false,
                theme = 'ivy',
                layout_config = { height = 13 },
            },
            git_branches = {
                previewer = false,
                theme = 'ivy',
                layout_config = { height = 13 },
                mappings = {
                    i = {
                        -- use Fugitive for checkout
                        ['<cr>'] = function(bufnr)
                            local selection = action_state.get_selected_entry()
                            if selection == nil then
                                utils.__warn_no_selection('actions.git_checkout')
                                return
                            end
                            actions.close(bufnr)
                            vim.cmd('Git checkout ' .. selection.value)
                        end
                    }
                }
            },
            quickfix = {
                preview_title = 'Preview',
                theme = 'ivy',
                layout_config = { height = 13 },
            },
            lsp_implementations = {
                prompt_title = 'Implementations',
                preview_title = 'Preview',
                theme = 'ivy',
                layout_config = { height = 13 },
            },
            lsp_definitions = {
                prompt_title = 'Definitions',
                preview_title = 'Preview',
                theme = 'ivy',
                layout_config = { height = 13 },
            },
            lsp_references = {
                prompt_title = 'References',
                preview_title = 'Preview',
                theme = 'ivy',
                layout_config = { height = 13 },
            },
            lsp_type_definitions = {
                prompt_title = 'Type Definitions',
                preview_title = 'Preview',
                theme = 'ivy',
                layout_config = { height = 13 },
            },
            git_bcommits = {
                prompt_title = 'Git Commits For Current File',
                theme = 'ivy',
                layout_config = { height = 13 },
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    })

    telescope.load_extension('fzy_native')

    vim.keymap.set('n', '<leader>f', builtin.find_files, opts)
    vim.keymap.set('n', '<leader>s', function() builtin.live_grep({ path_display = 'tail' }) end, opts)
    vim.keymap.set('n', '<leader>h', builtin.oldfiles, opts)
    vim.keymap.set('n', '<leader>o', builtin.buffers, opts)
    vim.keymap.set('n', '<leader>w', builtin.grep_string, opts)
    vim.keymap.set('n', '<leader>b', builtin.git_branches, opts)
    vim.keymap.set('n', '<leader>z', builtin.diagnostics, opts)
    vim.keymap.set('n', '<leader>q', builtin.quickfix, opts)
    vim.keymap.set('n', 'gL', builtin.git_commits, opts)
    vim.keymap.set('n', 'gh', builtin.git_bcommits, opts)
    vim.keymap.set('n', 'gs', builtin.git_stash, opts)
    vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, opts)
end)
