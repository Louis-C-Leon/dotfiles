pcall(function()
    vim.cmd('TSUpdate')
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'bash', 'c', 'comment', 'cmake', 'cpp', 'css', 'dockerfile', 'elixir',
            'gitattributes', 'gitignore', 'go', 'help', 'html', 'http', 'java',
            'javascript', 'jsdoc', 'json', 'lua', 'make', 'markdown', 'php',
            'perl', 'python', 'regex', 'ruby', 'rust', 'scala', 'scss', 'sql',
            'swift', 'toml', 'tsx', 'typescript', 'vim', 'yaml', 'org'
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'org' },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<C-g>',
                node_incremental = '<C-g>',
                node_decremental = '<C-h>'
            }
        },
        indent = { enable = true },
        textsubjects = {
            enable = true,
            keymaps = {
                ['<cr>'] = 'textsubjects-smart',
                [';'] = 'textsubjects-container-outer',
                ['i;'] = 'textsubjects-container-inner'
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['if'] = '@function.inner',
                    ['af'] = '@function.outer'
                }
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']]'] = '@function.outer'
                },
                goto_previous_start = {
                    ['[['] = '@function.outer'
                }
            }
        }
    })
end)
