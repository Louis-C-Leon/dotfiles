Vi = vim
Nmap = function(keys, result) Vi.api.nvim_set_keymap('n', keys, result, { noremap = true }) end
NmapCmd = function(keys, result) Vi.api.nvim_set_keymap('n', keys, '<cmd>' .. result .. '<CR>', { noremap = true }) end
VmapCmd = function(keys, result) Vi.api.nvim_set_keymap('v', keys, '<cmd>' .. result .. '<CR>', { noremap = true }) end

Vi.g.mapleader = ' '
Vi.opt.backup = false
Vi.opt.writebackup = false
Vi.opt.undofile = true
Vi.opt.autoread = true
Vi.opt.laststatus = 3
Vi.opt.termguicolors = true
Vi.opt.splitright = true
Vi.opt.splitbelow = true
Vi.opt.hlsearch = false
Vi.opt.ignorecase = true
Vi.opt.smartcase = true
Vi.opt.showmode = false
Vi.opt.lazyredraw = true
Vi.opt.swapfile = false
Vi.opt.scrolloff = 8
Vi.opt.sidescrolloff = 8
Vi.opt.mouse = 'a'
Vi.opt.updatetime = 25
Vi.opt.clipboard = 'unnamedplus'
Vi.opt.pumheight = 15
Vi.opt.expandtab = true
Vi.opt.smartindent = true
Vi.opt.shiftwidth = 4
Vi.opt.tabstop = 4
Vi.opt.softtabstop = 4
Vi.opt.number = true
Vi.opt.cursorline = true
Vi.opt.signcolumn = 'yes'
Vi.opt.wrap = false
Vi.opt.shortmess:append 'c'

NmapCmd('<C-h>', 'wincmd h')
NmapCmd('<C-j>','wincmd j')
NmapCmd('<C-k>', 'wincmd k')
NmapCmd('<C-l>', 'wincmd l')
NmapCmd('<C-z>', 'wincmd o')
NmapCmd('<C-q>', 'bd')
NmapCmd('<C-s>', 'wa')
NmapCmd('<leader>x', '%bd|e#|bd#')
NmapCmd('<leader><CR>', 'qa')
NmapCmd('qj', 'cnext')
NmapCmd('qk', 'cprev')
NmapCmd('qd', 'cfdo')
NmapCmd('qo', 'copen')
NmapCmd('qc', 'cclose')

Vi.cmd[[
  augroup Fugitive
    autocmd!
    autocmd FileType fugitive setlocal nonumber signcolumn=no
    autocmd FileType git setlocal nonumber signcolumn=no
    autocmd FileType gitcommit setlocal nonumber signcolumn=no
  augroup END

  fu! SaveSess()
      execute 'mksession! ' . getcwd() . '/.session.vim'
  endfunction

  fu! RestoreSess()
    if filereadable(getcwd() . '/.session.vim')
        execute 'so ' . getcwd() . '/.session.vim'
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exec 'sbuffer ' . l
                endif
            endfor
        endif
    endif
  endfunction

  augroup AutoSession
    autocmd!
    autocmd vimLeave * call SaveSess()
  augroup END
]]

NmapCmd('<leader>r', 'call RestoreSess()')

local packpath = Vi.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if Vi.fn.empty(Vi.fn.glob(packpath)) > 0 then
  PACKER_BOOTSTRAP = Vi.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packpath }
  print 'Installing packer. Close and reopen Neovim...'
  Vi.cmd 'packadd packer.nvim'
end
local packer_installed, packer = pcall(require, 'packer')
if not packer_installed then return end

return packer.startup(function(use)
  use { 'wbthomason/packer.nvim', 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
  use { 'b3nj5m1n/kommentary', 'tversteeg/registers.nvim', 'tpope/vim-surround', 'tpope/vim-sleuth'  }
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  use { 'windwp/nvim-autopairs', config = function () require('nvim-autopairs').setup() end }
  use { 'justinmk/vim-sneak', config = function() Vi.g['sneak#label'] = 1 end }
  use { 'Pocco81/AutoSave.nvim', config = function() require ('autosave').setup({ execution_message = '' }) end }
  use { 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim', config = function() Vi.cmd'colorscheme neobones' end }

  use {
    'skywind3000/asyncrun.vim',
    config = function()
      NmapCmd('<leader>P', 'AsyncRun -post=copen git push -u')
      NmapCmd('<leader>p', 'AsyncRun -post=copen git pull')
      Nmap('<leader>c', ':AsyncRun -post=copen git commit -m ""<left>')
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      Vi.g.indentLine_fileTypeExclude = {'fugitive', 'git', 'gitcommit', 'NvimTree'}
      require('indent_blankline').setup({ show_current_context = true })
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = false ,
          component_separators = { left ='|', right = '|'},
          section_separators = { left ='', right = ''}
        }
      })
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = { init_selection = '<C-a>', node_incremental = '<C-a>' }
        },
        indent = { enable = true }
      }
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      Vi.g.nvim_tree_show_icons = { folders = 1 }
      require('nvim-tree').setup({
        view = { hide_root_folder = true, width = 50 },
        update_focused_file = { enable = true }
      })
      NmapCmd('<leader>t', 'NvimTreeFindFile')
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-telescope/telescope-fzy-native.nvim'},
    config = function()
      local telescope = require('telescope')
      local act = require 'telescope.actions'
      telescope.setup{
        defaults = {
          file_ignore_patterns = { 'Pods', '.git' },
          mappings = {
            i = { ['<esc>'] = act.close, ['<C-j>'] = act.move_selection_next, ['<C-k>'] = act.move_selection_previous }
          }
        },
        extensions = { fzy_native = { override_generic_sorter = true, override_file_sorter = true } }
      }
      telescope.load_extension('fzy_native')
      NmapCmd('<leader>f', 'Telescope find_files theme=ivy')
      NmapCmd('<leader>h', 'Telescope oldfiles theme=ivy')
      NmapCmd('<leader>o', 'Telescope buffers theme=ivy')
      NmapCmd('<leader>/', 'Telescope current_buffer_fuzzy_find theme=ivy')
      NmapCmd('<leader>s', 'Telescope live_grep theme=ivy')
      NmapCmd('<leader>w', 'Telescope grep_string theme=ivy')
      NmapCmd('<leader>b', 'Telescope git_branches theme=ivy')
      NmapCmd('<leader>z', 'Telescope diagnostics theme=ivy')
      NmapCmd('<leader>i', 'Telescope lsp_implementations theme=ivy')
      NmapCmd('<leader>q', 'Telescope quickfix theme=ivy')
      NmapCmd('gl', 'Telescope git_commits theme=ivy')
      NmapCmd('gh', 'Telescope git_bcommits theme=ivy')
      NmapCmd('gs', 'Telescope git_stash theme=ivy')
      NmapCmd('gd', 'Telescope lsp_definitions theme=ivy')
      NmapCmd('gt', 'Telescope lsp_type_definitions theme=ivy')
      NmapCmd('gr', 'Telescope lsp_references theme=ivy')
    end
  }

  use {
    'tpope/vim-fugitive',
    config = function()
      NmapCmd('<leader>g', 'tab Git')
      NmapCmd('gL', 'tab Git log --pretty=short')
      NmapCmd('gb', 'tab Git blame --date=short')
      Nmap('g<space>', ':G<space>')
      Nmap('gv', ':Gvdiffsplit<space>')
    end
  }

  use {
    'tpope/vim-rhubarb',
    config = function()
      NmapCmd('go', 'GBrowse')
      VmapCmd('go', 'GBrowse')
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      NmapCmd('gj', 'Gitsigns next_hunk')
      NmapCmd('gk', 'Gitsigns prev_hunk')
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {'williamboman/nvim-lsp-installer', 'jose-elias-alvarez/null-ls.nvim', 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local my_servers = { 'bashls', 'cssls', 'html', 'jsonls', 'sumneko_lua', 'tsserver' }
      local null_ls = require('null-ls');
      require('nvim-lsp-installer').setup({ automatic_installation = true });
      null_ls.setup({ sources = { null_ls.builtins.formatting.prettier, null_ls.builtins.formatting.eslint_d } })
      Vi.lsp.handlers['textDocument/hover'] = Vi.lsp.with(Vi.lsp.handlers.hover, { border = 'single', width = 90 })
      for _, server_name in pairs(my_servers) do
        require('lspconfig')[server_name].setup({
          on_attach = function(client)
            if client.name == 'tsserver' then client.resolved_capabilities.document_formatting = false end
            NmapCmd('<C-f>', 'lua vim.lsp.buf.formatting()')
            NmapCmd('gD', 'lua vim.lsp.buf.declaration()')
            NmapCmd('ga', 'lua vim.lsp.buf.code_action()')
            NmapCmd('K', 'lua vim.lsp.buf.hover()')
            NmapCmd('rn', 'lua vim.lsp.buf.rename()')
            NmapCmd('zj', 'lua vim.diagnostic.goto_next()')
            NmapCmd('zk', 'lua vim.diagnostic.goto_prev()')
            NmapCmd('Z', 'lua vim.diagnostic.open_float()')
          end,
          capabilities = require('cmp_nvim_lsp').update_capabilities(Vi.lsp.protocol.make_client_capabilities())
        })
      end
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      local cmp = require('cmp')
      Vi.cmd'set completeopt=menu,menuone,noselect'
      cmp.setup {
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
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
        sources = {{ name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' }, { name = 'nvim_lsp_signature_help' }},
      }
    end
  }
  if PACKER_BOOTSTRAP then require('packer').sync() end
end)
