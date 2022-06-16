-- aliases for ease of config (cannot be local; packer configs will not work)
V = vim
Nmap = function(keys, result) V.api.nvim_set_keymap('n', keys, result, { noremap = true }) end
Ncmd = function(keys, result)
  V.api.nvim_set_keymap('n', keys, '<cmd>' .. result .. '<CR>', { noremap = true })
end
Vcmd = function(keys, result)
  V.api.nvim_set_keymap('v', keys, '<cmd>' .. result .. '<CR>', { noremap = true })
end

-- use spacebar as leader key
V.g.mapleader = ' '

-- reasonable default options. Use `:h <option>` to see more
V.opt.backup = false
V.opt.writebackup = false
V.opt.undofile = true
V.opt.autoread = true
V.opt.laststatus = 3
V.opt.termguicolors = true
V.opt.splitright = true
V.opt.splitbelow = true
V.opt.hlsearch = false
V.opt.ignorecase = true
V.opt.smartcase = true
V.opt.showmode = false
V.opt.lazyredraw = true
V.opt.swapfile = false
V.opt.scrolloff = 8
V.opt.sidescrolloff = 8
V.opt.mouse = 'a'
V.opt.updatetime = 25
V.opt.clipboard = 'unnamedplus'
V.opt.pumheight = 15
V.opt.expandtab = true
V.opt.smartindent = true
V.opt.shiftwidth = 4
V.opt.tabstop = 4
V.opt.softtabstop = 4
V.opt.number = true
V.opt.cursorline = true
V.opt.signcolumn = 'yes'
V.opt.wrap = false
V.opt.shortmess:append 'c'
V.cmd'set completeopt=menu,menuone,noselect'

-- window navigation hotkeys
Ncmd('<C-h>', 'wincmd h')
Ncmd('<C-j>','wincmd j')
Ncmd('<C-k>', 'wincmd k')
Ncmd('<C-l>', 'wincmd l')
Ncmd('<C-z>', 'wincmd o')

-- quickfix list navigation hotkeys
Ncmd('qj', 'cnext')
Ncmd('qk', 'cprev')
Ncmd('qd', 'cfdo')
Ncmd('qo', 'copen')
Ncmd('qc', 'cclose')

-- save all
Ncmd('<C-s>', 'wa')

-- close buffer
Ncmd('<C-q>', 'bd')

-- clear all buffers and windows except for focused window
-- TODO: often gets glitch where an unnamed/unsaved buffer persists from
-- completion or LSP
Ncmd('<leader>x', '%bd|e#|bd#')

-- <spacebar><enter> to quit neovim
Ncmd('<leader><CR>', 'qa')

-- autocommands TODO: clean it up, refactor
V.cmd[[
  augroup Fugitive
    autocmd!
    autocmd FileType fugitive setlocal nonumber signcolumn=no
    autocmd FileType git setlocal nonumber signcolumn=no
    autocmd FileType gitcommit setlocal nonumber signcolumn=no
  augroup END

  fu! SaveSess()
      execute 'NvimTreeClose'
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

-- restore previous session
Ncmd('<leader>r', 'call RestoreSess()')

-- try to bootstrap package manager if it's not installed
local packpath = V.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if V.fn.empty(V.fn.glob(packpath)) > 0 then
  PACKER_BOOTSTRAP = V.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packpath }
  print 'Installing packer. Close and reopen Neovim...'
  V.cmd 'packadd packer.nvim'
end
local packer_installed, packer = pcall(require, 'packer')
if not packer_installed then return end

-- all plugin configs and keymaps go here! download and execute arbitrary code from GitHub!!!!
-- TODO: use snapshots with Packer for better safety and stability.
return packer.startup(function(use)
  -- package manager and lua utils
  use { 'wbthomason/packer.nvim', 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }

  -- gcc (normal mode) or gc (visual mode) to comment out code
  use 'b3nj5m1n/kommentary'

  -- display register content in popup when operating on registers
  use 'tversteeg/registers.nvim'

  -- ys (normal mode) or s (visual mode) to surround with (), "", etc.
  use 'tpope/vim-surround'

  -- automatically complete pairs for (), [], etc.
  use {
    'windwp/nvim-autopairs',
    config = function () require('nvim-autopairs').setup() end
  }

  -- try to infer indentation width/chars from current file/project
  use 'tpope/vim-sleuth'

  -- highlight hex color strings with corresponding colors
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  }

  -- s and S (normal mode) for instant 2-char search/jump
  use { 'justinmk/vim-sneak', config = function() V.g['sneak#label'] = 1 end }

  -- autosave
  use { 'Pocco81/AutoSave.nvim', config = function() require ('autosave').setup({ execution_message = '' }) end }

  -- low-contrast zen color schemes
  use { 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim', config = function() V.cmd'colorscheme neobones' end }

  -- use async plug for some git actions because of hooks
  -- TODO: replace plugin with lua functions defined in this file
  use {
    'skywind3000/asyncrun.vim',
    config = function()
      Ncmd('<leader>P', 'AsyncRun -post=copen git push -u')
      Ncmd('<leader>p', 'AsyncRun -post=copen git pull')
      Nmap('<leader>c', ':AsyncRun -post=copen git commit -m ""<left>')
    end
  }

  -- pretty indent guides; highlight current indent level
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      V.g.indentLine_fileTypeExclude = {'fugitive', 'git', 'gitcommit', 'NvimTree'}
      require('indent_blankline').setup({ show_current_context = true })
    end
  }

  -- status line
  -- TODO: replace
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

  -- code-aware highlighting and incremental selection
  -- TODO: Add function/class/etc text objects
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

  -- file drawer; <leader>t to open
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        renderer = {
          icons = {
            webdev_colors = false,
            show = { folder = true, folder_arrow = false, file = false, git = false },
          },
        },
        filters = {
          custom = { '.git' }
        },
        update_focused_file = {
          enable = true,
        }
      })
      Ncmd('<leader>t', 'NvimTreeFindFile')
    end
  }

  -- telescope plugin and keymaps for fuzzy searching through any list of things
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
      Ncmd('<leader>f', 'Telescope find_files theme=ivy')
      Ncmd('<leader>h', 'Telescope oldfiles theme=ivy')
      Ncmd('<leader>o', 'Telescope buffers theme=ivy')
      Ncmd('<leader>/', 'Telescope current_buffer_fuzzy_find theme=ivy')
      Ncmd('<leader>s', 'Telescope live_grep theme=ivy')
      Ncmd('<leader>w', 'Telescope grep_string theme=ivy')
      Ncmd('<leader>b', 'Telescope git_branches theme=ivy')
      Ncmd('<leader>z', 'Telescope diagnostics theme=ivy')
      Ncmd('<leader>i', 'Telescope lsp_implementations theme=ivy')
      Ncmd('<leader>q', 'Telescope quickfix theme=ivy')
      Ncmd('gl', 'Telescope git_commits theme=ivy')
      Ncmd('gh', 'Telescope git_bcommits theme=ivy')
      Ncmd('gs', 'Telescope git_stash theme=ivy')
      Ncmd('gd', 'Telescope lsp_definitions theme=ivy')
      Ncmd('gt', 'Telescope lsp_type_definitions theme=ivy')
      Ncmd('gr', 'Telescope lsp_references theme=ivy')
    end
  }

  -- rich git integration
  use {
    'tpope/vim-fugitive',
    config = function()
      Ncmd('<leader>g', 'tab Git')
      Ncmd('gL', 'tab Git log --pretty=short')
      Ncmd('gb', 'tab Git blame --date=short')
      Nmap('g<space>', ':G<space>')
      Nmap('gv', ':Gvdiffsplit<space>')
    end
  }

  -- use `go` (normal or visual mode) to open code in GitHub
  use {
    'tpope/vim-rhubarb',
    config = function()
      Ncmd('go', 'GBrowse')
      Vcmd('go', 'GBrowse')
    end
  }

  -- visualize and navigate unstaged changes in file
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      Ncmd('gj', 'Gitsigns next_hunk')
      Ncmd('gk', 'Gitsigns prev_hunk')
    end
  }

  -- language server integration for IDE-like features
  use {
    'neovim/nvim-lspconfig',

    -- language installer, completion, and linting/formatting plugins
    requires = {'williamboman/nvim-lsp-installer', 'jose-elias-alvarez/null-ls.nvim', 'hrsh7th/cmp-nvim-lsp' },

    config = function()
      -- list of language servers to install
      local my_servers = { 'bashls', 'cssls', 'html', 'jsonls', 'sumneko_lua', 'tsserver' }
      require('nvim-lsp-installer').setup({ automatic_installation = true });

      -- integrate linting/formatting sources that aren't language servers
      local null_ls = require('null-ls');
      null_ls.setup({ sources = { null_ls.builtins.formatting.prettier, null_ls.builtins.formatting.eslint_d } })

      -- diagnostics display settings
      V.diagnostic.config({ virtual_text = { prefix = '' }, signs = false })

      -- language server `hover` info popup display settings
      V.lsp.handlers['textDocument/hover'] = V.lsp.with(V.lsp.handlers.hover, { border = 'single', width = 90 })

      -- set up language servers; set keymaps; integrate completion plugin
      -- more mappings for IDE features are in the Telescope config above.
      for _, server_name in pairs(my_servers) do
        require('lspconfig')[server_name].setup({
          on_attach = function(client)
            if client.name == 'tsserver' then client.resolved_capabilities.document_formatting = false end
            Ncmd('<C-f>', 'lua vim.lsp.buf.formatting()')
            Ncmd('gD', 'lua vim.lsp.buf.declaration()')
            Ncmd('ga', 'lua vim.lsp.buf.code_action()')
            Ncmd('K', 'lua vim.lsp.buf.hover()')
            Ncmd('rn', 'lua vim.lsp.buf.rename()')
            Ncmd('zj', 'lua vim.diagnostic.goto_next()')
            Ncmd('zk', 'lua vim.diagnostic.goto_prev()')
            Ncmd('Z', 'lua vim.diagnostic.open_float()')
          end,
          capabilities = require('cmp_nvim_lsp').update_capabilities(V.lsp.protocol.make_client_capabilities())
        })
      end
    end
  }

  -- modular autocomplete plugin
  -- NOTE: nvim-cmp currently requires a snippet plugin to work correctly.
  -- this config does not install any snippets.
  use {
    'hrsh7th/nvim-cmp',

    -- autocomplete sources
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
        sources = {{ name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' }, { name = 'nvim_lsp_signature_help' }},
      }
    end
  }

  if PACKER_BOOTSTRAP then require('packer').sync() end
end)
