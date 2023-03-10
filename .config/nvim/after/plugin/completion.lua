pcall(function()
    local cmp = require('cmp')
    cmp.setup({
        -- required for completion; install snippets to use
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        -- mappings for autocomplete menu. Default vim completion mappings like <C-n>, <C-x><C-l>, should still work.
        mapping = {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs( -1), { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable,
            ['<C-n>'] = cmp.config.disable,
            ['<C-l>'] = cmp.config.disable,
            ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
            ['<CR>'] = cmp.mapping.confirm { select = false },
        },
        formatting = { fields = { 'kind', 'abbr' } },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
            {
                name = 'buffer',
                option = {
                    -- use all open buffers for completion, not just current buffer
                    get_bufnrs = function() return vim.api.nvim_list_bufs() end
                }
            },
            { name = 'nvim_lsp_signature_help' },
        },
        completion = {
            keyword_length = 3,
        }
    })

    cmp.setup.cmdline('/', {
        mapping = vim.tbl_extend('force', cmp.mapping.preset.cmdline(), {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        }),
        sources = { { name = 'buffer' } }
    })

    cmp.setup.cmdline(':', {
        mapping = vim.tbl_extend('force', cmp.mapping.preset.cmdline(), {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        }),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
    })
end)
