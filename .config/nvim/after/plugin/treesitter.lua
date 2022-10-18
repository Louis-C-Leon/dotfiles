local function config()
    vim.cmd 'TSUpdate'
    -- try to install a parser for everything I might open in nvim, without installing all parsers
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'bash',
            'c',
            'c_sharp',
            'clojure',
            'comment',
            'commonlisp',
            'cmake',
            'cpp',
            'css',
            'dart',
            'dockerfile',
            'gitattributes',
            'gitignore',
            'go',
            'help',
            'html',
            'http',
            'java',
            'javascript',
            'jsdoc',
            'json',
            'lua',
            'make',
            'markdown',
            'php',
            'perl',
            'python',
            'regex',
            'ruby',
            'rust',
            'scala',
            'scss',
            'sql',
            'swift',
            'toml',
            'tsx',
            'typescript',
            'vim',
            'yaml'
        },
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<C-a>',
                scope_incremental = '<C-a>'
            }
        },
        indent = { enable = true },
        textsubjects = {
            enable = true,
            prev_selection = ',', -- (Optional) keymap to select the previous selection
            keymaps = {
                ['<cr>'] = 'textsubjects-smart',
                ['a;'] = 'textsubjects-container-outer',
                ['i;'] = 'textsubjects-container-inner',
            },
        },
    })
end

pcall(config)
