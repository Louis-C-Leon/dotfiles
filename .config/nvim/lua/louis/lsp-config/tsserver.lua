local M = {}
local default = require('louis.lsp-config.default')
local telescope_builtin = require('telescope.builtin')

M.setup_server = function()
    require('typescript').setup({ server = {
        on_attach = function(client, bufnr)
            local bufopts = { noremap = true, buffer = bufnr }
            default.setup_opts.on_attach(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            vim.keymap.set('n', '<leader>i', require('typescript').actions.addMissingImports, bufopts)
            vim.keymap.set('n', '<leader>I', require('typescript').actions.organizeImports, bufopts)
            vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, bufopts)
            vim.keymap.set('n', 'RN', function() vim.cmd('TypescriptRenameFile') end, bufopts)
        end,
        capabilities = default.capabilities,
    } })
end

return M
