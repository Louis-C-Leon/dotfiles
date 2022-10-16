-- Plugin repos are hosted at https://github.com/{plugin_path}. I put configs for these plugins in .config/nvim/after/plugin/
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
    use 'nvim-tree/nvim-tree.lua' -- filetree window
    use {
        'nvim-telescope/telescope.nvim', -- incremental fuzzy finding with builtin commands
        requires = 'nvim-telescope/telescope-fzy-native.nvim' -- use faster finder
    }
    use 'tpope/vim-fugitive' -- all the git integration you need
    use 'tpope/vim-rhubarb' -- provides ':GBrowse' cmd to open code in GitHub
    use 'lewis6991/gitsigns.nvim' -- more git visual feedback and commands
    use {
        'williamboman/mason.nvim', -- installs and manages IDE tools like language servers, linters, and formatters
        requires = {
            'jose-elias-alvarez/null-ls.nvim', -- let linters and formatters hook in to nvim's LSP client
            'jayp0521/mason-null-ls.nvim', -- integrate null_ls and mason.nvim to play nicely
            'neovim/nvim-lspconfig', -- language server config utils, maintained by neovim core team
            'williamboman/mason-lspconfig.nvim', -- integrate nvim-lspconfig and mason.nvim to play nicely
            'hrsh7th/cmp-nvim-lsp' -- integrate language servers with autocomplete framework
        }
    }
    use {
        'hrsh7th/nvim-cmp', -- modular autocomplete plugin; no sources included
        requires = {
            'hrsh7th/cmp-nvim-lsp', -- autocomplete from language servers
            'hrsh7th/cmp-buffer', -- autocomplete from current file text
            'hrsh7th/cmp-path', -- autocomplete file paths from neovim cwd
            'hrsh7th/cmp-nvim-lsp-signature-help', -- use autocomplete UI to show help when typing function args
        }
    }
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
