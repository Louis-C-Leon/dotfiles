local language_servers = { 'bashls', 'cssls', 'html', 'jsonls', 'sumneko_lua', 'tsserver' }

local function setup_server(server_name)
    require('lspconfig')[server_name].setup({
        on_attach = function(client, bufnr)
            -- I want prettier to format JS and TS, not tsserver
            if client.name == 'tsserver' then
                client.server_capabilities.documentFormattingProvider = false
            end

            -- keymaps; other actions like goto definition or references are handled by telescope, see ./telescope.lua
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', '<C-f>', function() vim.lsp.buf.format { async = true } end, bufopts)
        end,

        -- integrate language server with autocomplete framework.
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    })
end

local function setup_diagnostics()
    local opts = { noremap = true, silent = true }
    vim.diagnostic.config({
        virtual_text = { prefix = '' },
        float = { width = 90 },
        signs = false
    })

    -- ./telescope.lua configures the keymap to search through all diagnostics
    vim.keymap.set('n', 'Z', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', 'zk', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', 'zj', vim.diagnostic.goto_next, opts)
end

local function setup_lsp_handlers()
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { width = 90 }
    )
end

local function config()
    setup_diagnostics()
    setup_lsp_handlers()

    -- mason handles installing required packages for language servers, linters, and formatters
    require('mason').setup()

    -- integrate linters and formatters into nvim lsp client
    local null_ls = require('null-ls');
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.diagnostics.eslint_d
        }
    })
    require('mason-null-ls').setup({ automatic_installation = true })

    -- install and setup language servers
    require('mason-lspconfig').setup({ ensure_installed = language_servers })
    require('mason-lspconfig').setup_handlers({ setup_server })
end

pcall(config)
