-- plugins installed from GitHub. See nvim/after/plugin/ for configuration
local function install_plugins(use)
    use 'wbthomason/packer.nvim' -- plugin manager
    use 'nvim-lua/popup.nvim' -- UI library (common plugin dependency)
    use 'nvim-lua/plenary.nvim' -- lua utility library (common plugin dependency)
    use 'EdenEast/nightfox.nvim' -- pretty themes
    use 'NvChad/nvim-colorizer.lua' -- highlight hex color codes
    use 'numToStr/Comment.nvim' -- smart commenting plugin
    use 'tpope/vim-surround' -- enhanced functionality for 'surrounding' chars, e.g. () {}
    use 'windwp/nvim-autopairs' -- autocomplete paired chars
    use 'Darazaki/indent-o-matic' -- auto-set vim indent options based on current file
    use 'nvim-treesitter/nvim-treesitter' -- pretty highlighting and incremental selection
    use {
        'nvim-neo-tree/neo-tree.nvim', -- filetree explorer
        branch = 'v2.x',
        requires = 'MunifTanjim/nui.nvim' -- another UI library
    }
    use {
        'nvim-telescope/telescope.nvim', -- incremental fuzzy finding with batteries included
        requires = 'nvim-telescope/telescope-fzy-native.nvim' -- use faster finder
    }
    use 'tpope/vim-fugitive' -- all the git integration you need
    use 'tpope/vim-rhubarb' -- provides ':GBrowse' cmd to open code in GitHub
    use 'lewis6991/gitsigns.nvim' -- more git visual feedback and commands
    use {
        'williamboman/mason.nvim', -- installs and manages language tools like language servers, linters, and formatters
        requires = {
            'jose-elias-alvarez/null-ls.nvim', -- lets linters and formatters hook in to nvim's LSP client
            'neovim/nvim-lspconfig',
            'williamboman/mason-lspconfig.nvim'
        }
    }

    -- language server integration for IDE-like features
    -- TODO: use mason.nvim
    use {
        'neovim/nvim-lspconfig',
        -- language installer, completion, and linting/formatting plugins
        requires = {
            'williamboman/nvim-lsp-installer',
            'jose-elias-alvarez/null-ls.nvim',
            'hrsh7th/cmp-nvim-lsp'
        }
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
        }
    }

    -- run PackerSync if packer has just been bootstrapped
    if PACKER_BOOTSTRAP then require('packer').sync() end
end

-- try to bootstrap package manager if it's not installed
local packpath = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packpath)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        packpath
    }
    print 'Installing packer. Close and reopen Neovim...'
    vim.cmd 'packadd packer.nvim'
end
local packer_installed, packer = pcall(require, 'packer')
if not packer_installed then return end

-- TODO: use snapshots with Packer for better safety and stability.
return packer.startup(
    function(use)
        install_plugins(use)

        -- run PackerSync if packer has just been bootstrapped
        if PACKER_BOOTSTRAP then require('packer').sync() end
    end
)
