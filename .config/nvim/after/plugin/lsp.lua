local default_setup = require('louis.lsp-config.default')
local break_into_lines = require('louis.format-utils').break_into_lines

-- list of language servers to install; add more servers here when needed
-- run `:Mason` command to see info on available servers and updates
local language_servers = { 'bashls', 'cssls', 'html', 'jsonls', 'lua_ls', 'tsserver' }

-- If I need server-specific config, create a new file `.config/nvim/lua/louis/lsp-config/{server_name}`
-- The file should export a function named `setup_server`
local function setup_server(server_name)
    local has_custom_setup, custom_setup = pcall(require, 'louis.lsp-config.' .. server_name)
    if has_custom_setup then
        custom_setup.setup_server(server_name)
    else
        default_setup.setup_server(server_name)
    end
end

local function setup_diagnostics()
    local opts = { noremap = true }
    vim.diagnostic.config({
        virtual_text = false,
        float = {
            border = 'single',
            format = function(diagnostic)
                return break_into_lines(diagnostic.message, 85)
            end
        },
        signs = false,
    })

    -- ./telescope.lua configures the keymap to search through all diagnostics
    vim.keymap.set('n', 'Z', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', 'zk', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', 'zj', vim.diagnostic.goto_next, opts)
end

local function setup_lsp_handlers()
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'single' }
    )
end

pcall(function()
    -- plugin for installing language servers, linters, and formatters
    require('mason').setup()

    -- configure and install linters and formatters
    local null_ls = require('null-ls');
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.diagnostics.eslint_d
        }
    })
    require('mason-null-ls').setup({ automatic_installation = true })

    -- configure and install language servers
    require('mason-lspconfig').setup({ ensure_installed = language_servers })
    require('mason-lspconfig').setup_handlers({ setup_server })
    setup_diagnostics()
    setup_lsp_handlers()
end)
