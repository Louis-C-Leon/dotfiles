local function config()
    local opts = { noremap = true, silent = true }
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')

    telescope.setup({
        defaults = {
            file_ignore_patterns = { 'Pods', '.git' },
            layout_strategy = 'center',
            layout_config = { anchor = 'N' },
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
            borderchars = { '', '', '', '', '', '', '', '' },
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
                layout_config = { height = 0.6 },
                hidden = true,
                previewer = false,
            },
            live_grep = {
                prompt_title = 'Live Search',
                preview_title = 'Preview'
            },
            grep_string = {
                preview_title = 'Preview'
            },
            oldfiles = {
                prompt_title = 'Recent Files',
                previewer = false,
            },
            buffers = {
                prompt_title = 'Open Files',
                previewer = false,
            },
            current_buffer_fuzzy_find = {
                prompt_title = 'Current File Fuzzy Search',
                layout_config = { height = 0.6 },
                previewer = false,
            },
            git_branches = {
                previewer = false,
            },
            quickfix = {
                preview_title = 'Preview'
            },
            lsp_implementations = {
                prompt_title = 'Implementations',
                preview_title = 'Preview'
            },
            lsp_definitions = {
                prompt_title = 'Definitions',
                preview_title = 'Preview'
            },
            lsp_references = {
                prompt_title = 'References',
                preview_title = 'Preview'
            },
            lsp_type_definitions = {
                prompt_title = 'Type Definitions',
                preview_title = 'Preview'
            },
            git_bcommits = {
                prompt_title = 'Git Commits For Current File'
            }
        },
    })

    telescope.load_extension('fzy_native')

    vim.keymap.set('n', '<leader>f', builtin.find_files, opts)
    vim.keymap.set('n', '<leader>s', builtin.live_grep, opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
    vim.keymap.set('n', '<leader>h', builtin.oldfiles, opts)
    vim.keymap.set('n', '<leader>o', builtin.buffers, opts)
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, opts)
    vim.keymap.set('n', '<leader>w', builtin.grep_string, opts)
    vim.keymap.set('n', '<leader>b', builtin.git_branches, opts)
    vim.keymap.set('n', '<leader>z', builtin.diagnostics, opts)
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set('n', '<leader>q', builtin.quickfix, opts)
    vim.keymap.set('n', 'gl', builtin.git_commits, opts)
    vim.keymap.set('n', 'gh', builtin.git_bcommits, opts)
    vim.keymap.set('n', 'gs', builtin.git_stash, opts)
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, opts)

    vim.cmd 'hi! link TelescopeTitle IncSearch'
    vim.cmd 'hi! link TelescopeBorder NormalFloat'
    vim.cmd 'hi! link TelescopeNormal NormalFloat'
    vim.cmd 'hi! link TelescopePreviewNormal NormalFloat'
end

pcall(config)
