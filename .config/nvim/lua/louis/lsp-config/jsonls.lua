local M = {}
local setup_opts = require('louis.lsp-config.default').setup_opts

setup_opts.settings = {
    json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true }
    }
}

M.setup_server = function(server_name)
    require('lspconfig')[server_name].setup(setup_opts)
end

return M
