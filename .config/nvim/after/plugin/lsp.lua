local function config()
    local util = require('louis.util')
    require('mason').setup()
    require('mason-lspconfig').setup()
    local my_servers = { 'bashls', 'cssls', 'html', 'jsonls', 'sumneko_lua', 'tsserver' }
--     require('nvim-lsp-installer').setup({ automatic_installation = true });
--
--     -- integrate linting/formatting sources that aren't language servers
--     local null_ls = require('null-ls');
--     null_ls.setup({ sources = { null_ls.builtins.formatting.prettier, null_ls.builtins.formatting.eslint_d } })
--
--     -- diagnostics display settings
--     vim.diagnostic.config({ virtual_text = { prefix = '' }, float = { width = 90 }, signs = false })
--
--     -- language server `hover` info popup display settings
--     vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { width = 90 })
--
--     -- set up language servers; set keymaps; integrate completion plugin
--     for _, server_name in pairs(my_servers) do
--         require('lspconfig')[server_name].setup({
--             on_attach = function(client)
--                 -- I want prettier to format JS and TS, not tsserver
--                 if client.name == 'tsserver' then client.resolved_capabilities.document_formatting = false end
--                 util.ncmd('<C-f>', 'lua vim.lsp.buf.formatting()')
--                 util.ncmd('gD', 'lua vim.lsp.buf.declaration()')
--                 util.ncmd('ga', 'lua vim.lsp.buf.code_action()')
--                 util.ncmd('K', 'lua vim.lsp.buf.hover()')
--                 util.ncmd('rn', 'lua vim.lsp.buf.rename()')
--                 util.ncmd('zj', 'lua vim.diagnostic.goto_next()')
--                 util.ncmd('zk', 'lua vim.diagnostic.goto_prev()')
--                 util.ncmd('Z', 'lua vim.diagnostic.open_float()')
--             end,
--             capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--         })
--     end
end

pcall(config)
