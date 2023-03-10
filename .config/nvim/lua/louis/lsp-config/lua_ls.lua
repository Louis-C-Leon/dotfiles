local M = {}
local setup_opts = require('louis.lsp-config.default').setup_opts

setup_opts.settings = {
    Lua = {
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
            },
        },
    },
}

M.setup_server = function(server_name)
    require('lspconfig')[server_name].setup(setup_opts)
end

return M
