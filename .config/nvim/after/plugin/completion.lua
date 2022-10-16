local function config()
    local cmp = require('cmp')
    cmp.setup {
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },

        -- mappings for autocomplete menu. Default vim completion mappings like <C-n>, <C-x><C-l>, should still work.
        mapping = {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable,
            ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
            ['<CR>'] = cmp.mapping.confirm { select = false },
        },
        formatting = { fields = { 'kind', 'abbr' } },
        sources = { { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' },
            { name = 'nvim_lsp_signature_help' } },
    }
end

pcall(config)
