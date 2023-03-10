local telescope_builtin = require('telescope.builtin')

local M = {}

M.setup_opts = {
    on_attach = function(client, bufnr)
        -- set language server keymaps
        local bufopts = { noremap = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<C-f>', function() vim.lsp.buf.format({ async = true }) end, bufopts)
        vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, bufopts)
        vim.keymap.set('n', 'gi', telescope_builtin.lsp_implementations, bufopts)
        vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, bufopts)

        -- autoformat on save
        vim.api.nvim_create_autocmd(
            'BufWritePre',
            {
                group = vim.api.nvim_create_augroup(
                    'AutoFormat',
                    { clear = true }
                ),
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(formatter) return formatter.name ~= "tsserver" end
                    })
                end
            }
        )
    end,

    -- integrate language server with autocomplete framework.
    capabilities = require('cmp_nvim_lsp').default_capabilities()
}

M.setup_server = function(server_name)
    require('lspconfig')[server_name].setup(M.setup_opts)
end

return M
